import Foundation
import UIKit
import Alamofire
import Dependencies
import Sharing
import DTOs

public struct ErrorResponse: Error, Decodable {
    public let error: Bool
    public let reason: String
}

public extension DataRequest {
    
    func serializingValue<Value: Decodable>(
        _ type: Value.Type = Value.self,
        emptyResponseCodes: Set<Int> = DecodableResponseSerializer<Value>.defaultEmptyResponseCodes
    ) async throws -> Value {
        try await self
            .serializingDecodable(
                Value.self,
                decoder: JSONDecoder.decoder,
                emptyResponseCodes: emptyResponseCodes
            )
            .value
    }
}

// MARK: - Protocol

protocol IRequestsService {
    
    func upload(
        path: String,
        fileName: String,
        data: Data,
        mimeType: String
    ) -> UploadRequest
    
    func request<Parameters: Encodable>(
        path: String,
        method: HTTPMethod,
        parameters: Parameters?
    ) -> DataRequest
    
    func request(
        path: String,
        method: HTTPMethod
    ) -> DataRequest
    
    func logout() -> DataRequest
}

// MARK: - DependencyValues

extension DependencyValues {
    
    var requestsService: any IRequestsService {
        get { self[RequestsServiceKey.self] }
        set { self[RequestsServiceKey.self] = newValue }
    }
    
    enum RequestsServiceKey: DependencyKey {
        static var liveValue: IRequestsService = {
            let monitors = [RequestsService.eventMonitor].compactMap { $0 }
            
            let configuration = URLSessionConfiguration.default
            configuration.headers = [
                .defaultAcceptEncoding,
                .defaultAcceptLanguage,
                .defaultUserAgent
            ]

            let session = Session(
                configuration: configuration,
                delegate: SessionDelegate(),
                rootQueue: DispatchQueue(label: "app.maestri.session.rootQueue"),
                startRequestsImmediately: true,
                requestQueue: .none,
                serializationQueue: .none,
                interceptor: .none,
                serverTrustManager: .none,
                redirectHandler: .none,
                cachedResponseHandler: .none,
                eventMonitors: monitors
            )
            
            return RequestsService(
                session: session,
                authenticator: JWTAuthenticator()
            )
        }()
    }
}

// MARK: - Live

public struct RequestsService: IRequestsService {
    
    //TODO: Вернуть переключение между серверами
    public static var baseURL = URL(string: "https://api.maestri.me")!
    public static var eventMonitor: EventMonitor?
    
    @Shared(.iAmState) var requesterType: RequesterType?
    @Shared(.accessJWT()) var accessToken: Token?
    @Shared(.refreshJWT()) var refreshToken: Token?
    @Shared(.deviceId) var deviceId: UUID = UIDevice.current.identifierForVendor ?? UUID()
    
    private var decoder = JSONDecoder.decoder
    private var bodyEncoder = JSONParameterEncoder.bodyEncoder
    private var queryEncoder = URLEncodedFormParameterEncoder.queryEncoder
    
    private var validation: DataRequest.Validation = { request, response, data in
        switch response.statusCode {
        case 200...299:
            return .success(())
        case 400...499:
            guard let data, let error = try? JSONDecoder().decode(ErrorResponse.self, from: data) else {
                return .failure(AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: response.statusCode)))
            }
            return .failure(error)
        default:
            return .failure(AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: response.statusCode)))
        }
    }
    
    // MARK: - Init
    
    private var session: Session
    private var authenticator: JWTAuthenticator
    
    init(session: Session, authenticator: JWTAuthenticator) {
        self.session = session
        self.authenticator = authenticator
    }
}

extension RequestsService {
    
    func request(
        path: String,
        method: HTTPMethod
    ) -> DataRequest {
        request(
            path: path,
            method: method,
            parameters: nil as Empty?
        )
    }
    
    func request<Parameters: Encodable>(
        path: String,
        method: HTTPMethod,
        parameters: Parameters? = nil as Empty?
    ) -> DataRequest {
        
        let url = RequestsService.baseURL.appending(path: path)
        
        let encoder: ParameterEncoder
        switch method {
        case .post, .put, .patch:
            encoder = bodyEncoder
        default:
            encoder = queryEncoder
        }
        
        // Обработка Headers
        var headers = HTTPHeaders()
        headers.requesterType = requesterType
        headers.deviceId = deviceId.uuidString
        
        var interceptor: RequestInterceptor?
        if let token = refreshToken {
            interceptor = AuthenticationInterceptor(
                authenticator: authenticator,
                credential: JWTCredential(token: accessToken)
            )
        }
        
        // Создания запроса
        let dataRequest = session.request(
            url,
            method: method,
            parameters: parameters,
            encoder: encoder,
            headers: headers,
            interceptor: interceptor,
            requestModifier: .none
        )
        return dataRequest
            .validate(validation)
    }
    
    func upload(
        path: String,
        fileName: String,
        data: Data,
        mimeType: String
    ) -> UploadRequest {
        
        var url = RequestsService.baseURL
        url.append(path: path)
        
        // Обработка Headers
        var headers = HTTPHeaders()
        headers.requesterType = requesterType
        headers.deviceId = deviceId.uuidString
        
        let uploadRequest = session.upload(
            multipartFormData: { multipart in
                //withName: "image" является ключом по которому кладётся data
                let keyName = "image"
                multipart.append(data, withName: keyName, fileName: fileName, mimeType: mimeType)
            },
            to: url,
            headers: headers,
            interceptor: AuthenticationInterceptor(
                authenticator: authenticator,
                credential: JWTCredential(token: accessToken)
            )
        )
        
        return uploadRequest
            .validate(validation)
    }
    
    func logout() -> DataRequest {
        var url = RequestsService.baseURL
        url.append(path: "/v1/logout")
        
        // Обработка Headers
        var headers = HTTPHeaders()
        headers.requesterType = requesterType
        headers.deviceId = deviceId.uuidString
        
        if let token = refreshToken {
            headers.add(.authorization(bearerToken: token.value))
        }
        
        let dataRequest = session.request(url, method: .post, headers: headers)
        return dataRequest
            .validate(validation)
    }
}

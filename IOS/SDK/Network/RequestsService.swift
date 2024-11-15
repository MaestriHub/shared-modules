import Foundation
import Alamofire
import Dependencies

enum RequestType {
    case session
    case other
}

struct ErrorResponse: Error, Decodable {
    let error: Bool
    let reason: String
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
        parameters: Parameters?,
        requestType: RequestType
    ) -> DataRequest
    
    func request(
        path: String,
        method: HTTPMethod,
        requestType: RequestType
    ) -> DataRequest
}

// MARK: - DependencyValues

extension DependencyValues {
    
    var requestsService: any IRequestsService {
        get { self[RequestsServiceKey.self] }
        set { self[RequestsServiceKey.self] = newValue }
    }
    
    enum RequestsServiceKey: DependencyKey {
        static var liveValue: IRequestsService {
            let monitors = [RequestsService.eventMonitor].compactMap { $0 }
            
            let session = Session(
                configuration: URLSessionConfiguration.af.default,
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
        }
    }
}

// MARK: - Live

public struct RequestsService: IRequestsService {
    
    static var baseURL = URL(string: "https://api.maestri.me")!
    static var eventMonitor: EventMonitor?
    
    // MARK: - Dependencies
    
    @Dependency(\.secureStorageService) var secureStorageService
    @Dependency(\.coderService) var coderService
    
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
        method: HTTPMethod,
        requestType: RequestType
    ) -> DataRequest {
        request(
            path: path,
            method: method,
            parameters: nil as Empty?,
            requestType: requestType
        )
    }
    
    func request<Parameters: Encodable>(
        path: String,
        method: HTTPMethod,
        parameters: Parameters? = nil as Empty?,
        requestType: RequestType
    ) -> DataRequest {
        
        var url = RequestsService.baseURL
        url.append(path: path)
        
        let encoder: ParameterEncoder
        switch method {
        case .post, .put, .patch:
            encoder = coderService.bodyEncoder
        default:
            encoder = coderService.queryEncoder
        }
        
        // Обработка Headers
        var headers = HTTPHeaders()
        headers.requesterType = secureStorageService.currentIAm
        headers.deviceId = secureStorageService.deviceId
        
        var interceptor: RequestInterceptor?
        switch requestType {
        case .session:
            if let token = secureStorageService.refreshToken {
                headers.add(.authorization(bearerToken: token.value))
            }
        case .other:
            interceptor = AuthenticationInterceptor(
                authenticator: authenticator,
                credential: JWTCredential(token: secureStorageService.accessToken)
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
            .validate({ _, response, data in
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
            })
    }
    
    func upload(
        path: String,
        fileName: String,
        data: Data,
        mimeType: String
    ) -> UploadRequest {
        
        var url = RequestsService.baseURL
        url.append(path: path)
        
        return session.upload(
            multipartFormData: { multipart in
                //withName: "image" является ключом по которому кладётся data
                let keyName = "image"
                multipart.append(data, withName: keyName, fileName: fileName, mimeType: mimeType)
            },
            to: url,
            interceptor: AuthenticationInterceptor(
                authenticator: JWTAuthenticator(),
                credential: JWTCredential(token: secureStorageService.accessToken)
            )
        )
    }
}

import Foundation
import Alamofire
import Dependencies
import Pulse
import Mocker

//MARK: - Protocol

protocol IRequestsService {

    func request<Parameters: Encodable>(
        path: String,
        method: HTTPMethod,
        parameters: Parameters?
    ) -> DataRequest
    
    func request(
        path: String,
        method: HTTPMethod
    ) -> DataRequest
    
    func mockedRequest<Parameters: Encodable>(
        mock: Data,
        path: String,
        method: HTTPMethod,
        parameters: Parameters?
    ) -> DataRequest
    
    func mockedRequest(
        mock: Data,
        path: String,
        method: HTTPMethod
    ) -> DataRequest
}

//MARK: - DependencyValues

extension DependencyValues {
    
    var requestsService: any IRequestsService {
        get { self[RequestsServiceKey.self] }
        set { self[RequestsServiceKey.self] = newValue }
    }
    
    enum RequestsServiceKey: DependencyKey {
        public static let liveValue: IRequestsService = RequestsService()
    }
}

//MARK: - Live

final class RequestsService: IRequestsService {
            
    //MARK: - Dependencies
    
    @Dependency(\.tokenStorageService) var tokenStorageService
    @Dependency(\.mockService) var mockService
    
    var base: URL {
        return URL(string: "http://127.0.0.1:8080")!
//        return URL(string: "https://maestri-app-76rqlbff5q-wl.a.run.app")!
    }
    
    lazy var session: Session = {
        // Logger for Pulse
        URLSessionProxyDelegate.enableAutomaticRegistration()
        Experimental.URLSessionProxy.shared.isEnabled = true
        
        var configuration = URLSessionConfiguration.af.default
        
        // TODO: Setup for Mocker надо переделать что бы только в тесте использовалось
        mockService.setup(for: configuration)
        Mocker.mode = .optin
        
        let session = Session(
            configuration: configuration,
            delegate: SessionDelegate(),
            rootQueue: DispatchQueue(label: "app.maestri.session.rootQueue"),
            startRequestsImmediately: true,
            requestQueue: nil,
            serializationQueue: nil,
            interceptor: nil, //RequestInterceptor
            serverTrustManager: nil, //ServerTrustManager
            redirectHandler: nil, //RedirectHandler
            cachedResponseHandler: nil, //CachedResponseHandler
            eventMonitors: [] //[EventMonitor]
        )
        
        return session
    }()
    
    func request<Parameters: Encodable>(
        path: String,
        method: HTTPMethod,
        parameters: Parameters? = nil as Empty?
    ) -> DataRequest {
        
        var url = base
        url.append(path: path)
        
        // Обработка Headers
        var headers: HTTPHeaders?
        if let token = tokenStorageService.token {
            headers =  [
                .authorization(bearerToken: token)
            ]
        }
        
        let encoder: ParameterEncoder
        switch method {
        case .post, .put, .patch:
            encoder = JSONParameterEncoder()
        default:
            encoder = URLEncodedFormParameterEncoder(destination: .queryString)
        }
           
        // Создания запроса
        let dataRequest = session.request(
            url,
            method: method,
            parameters: parameters,
            encoder: encoder,
            headers: headers,
            interceptor: .none,
            requestModifier: .none
        )
        return dataRequest
    }
    
    func request(
        path: String,
        method: HTTPMethod
    ) -> DataRequest {
        return request(path: path, method: method, parameters: nil as Empty?)
    }
    
    func mockedRequest<Parameters: Encodable>(
        mock: Data,
        path: String,
        method: HTTPMethod,
        parameters: Parameters?
    ) -> DataRequest {
        mockService.registerMock(for: path, method: method, response: mock)

        return request(path: path, method: method, parameters: parameters)
    }
    
    func mockedRequest(
        mock: Data,
        path: String,
        method: HTTPMethod
    ) -> DataRequest {
        return mockedRequest(mock: mock, path: path, method: method, parameters: nil as Empty?)
    }
}

import Foundation
import UIKit
import Alamofire
import Dependencies
import Sharing
import DTOs

struct JWTCredential: AuthenticationCredential {
    
    var token: Token?
    
    var requiresRefresh: Bool {
        guard token?.value != nil, let expiration = token?.expiration else { return false }
        return expiration <= Date.now
    }
}

final class JWTAuthenticator: Authenticator, @unchecked Sendable {
    
    @Shared(.iAmState) var requesterType: RequesterType?
    @Shared(.accessJWT()) var accessToken: Token?
    @Shared(.refreshJWT()) var refreshToken: Token?
    @Shared(.deviceId) var deviceId: UUID = UIDevice.current.identifierForVendor ?? UUID()
    
    private let queue = DispatchQueue(label: "app.maestri.authenticator", attributes: .concurrent)
    private var isRefreshing = false
    private var refreshCompletions: [(Result<JWTCredential, Error>) -> Void] = []
    
    func apply(_ credential: JWTCredential, to urlRequest: inout URLRequest) {
        guard let token = credential.token else { return }
        urlRequest.headers.add(.authorization(bearerToken: token.value))
    }
    
    func refresh(_ credential: JWTCredential, for session: Session, completion: @escaping (Result<JWTCredential, Error>) -> Void) {
        queue.async(flags: .barrier) {
            if self.isRefreshing {
                self.refreshCompletions.append(completion)
                return
            }
            
            self.isRefreshing = true
            self.refreshCompletions.append(completion)
        }
        
        let url = RequestsService.baseURL.appending(path: "/v1/refresh")
        
        var headers = HTTPHeaders()
        headers.requesterType = requesterType
        headers.deviceId = deviceId.uuidString
        if let token = refreshToken {
            headers.add(.authorization(bearerToken: token.value))
        }
        
        session.request(url, method: .post, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Auth.Responses.Partial.self, decoder: JSONDecoder.decoder) { response in
                self.queue.async(flags: .barrier) {
                    self.isRefreshing = false
                    let result: Result<JWTCredential, Error>
                    
                    switch response.result {
                    case .success(let value):
                        self.$accessToken.withLock { $0 = value.accessToken }
                        if let refreshToken = value.refreshToken {
                            self.$refreshToken.withLock { $0 = refreshToken }
                        }
                        let credential = JWTCredential(token: value.accessToken)
                        result = .success(credential)
                    case .failure(let error):
                        guard let alamofireError = error.asAFError else {
                            result = .failure(error)
                            break
                        }
                        
                        if let responseCode = alamofireError.responseCode, responseCode == 401 {
                            // Только если сервер вернул 401, сбрасываем токены
                            self.$accessToken.withLock { $0 = nil }
                            self.$refreshToken.withLock { $0 = nil }
                        }
                        
                        result = .failure(error)
                    }
                    
                    // Завершаем все ожидающие обновления запросы
                    let completions = self.refreshCompletions
                    self.refreshCompletions.removeAll()
                    
                    completions.forEach { $0(result) }
                }
            }
    }
    
    func didRequest(_ urlRequest: URLRequest, with response: HTTPURLResponse, failDueToAuthenticationError error: Error) -> Bool {
        guard let afError = error.asAFError else { return false }
        
        if let responseCode = afError.responseCode {
            return responseCode == 401
        }
        
        return false
    }
    
    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: JWTCredential) -> Bool {
        guard let token = credential.token else { return true }
        return urlRequest.headers.contains(.authorization(bearerToken: token.value))
    }
}

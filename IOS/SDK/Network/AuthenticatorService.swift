import Foundation
import Alamofire
import Dependencies
import DTOs

struct JWTCredential: AuthenticationCredential {
    
    var token: Token?
    
    var requiresRefresh: Bool {
        guard token?.value != nil, let expiration = token?.expiration else { return false }
        
        return expiration <= Date.now
    }
}

final class JWTAuthenticator: Authenticator, @unchecked Sendable {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.coderService) var coderService
    @Dependency(\.secureStorageService) var secureStorageService
    
    // MARK: - Authenticator
    
    func apply(_ credential: JWTCredential, to urlRequest: inout URLRequest) {
        guard let token = credential.token else { return }
        urlRequest.headers.add(.authorization(bearerToken: token.value))
    }
    
    func refresh(_ credential: JWTCredential, for session: Session, completion: @escaping (Result<JWTCredential, Error>) -> Void) {
        requestsService
            .request(path: "/v1/refresh", method: .post, requestType: .session)
            .responseDecodable(of: Auth.Responses.Partial.self, decoder: coderService.decoder) { response in
                switch response.result {
                case .success(let value):
                    self.secureStorageService.setAccess(token: value.accessToken)
                    if let refreshToken = value.refreshToken {
                        self.secureStorageService.setRefresh(token: refreshToken)
                    }
                    let credential = JWTCredential(token: value.accessToken)
                    completion(.success(credential))
                case .failure(let error):
                    self.secureStorageService.setRefresh(token: nil)
                    self.secureStorageService.setAccess(token: nil)
                    completion(.failure(error))
                }
            }
    }
    
    func didRequest(_ urlRequest: URLRequest, with response: HTTPURLResponse, failDueToAuthenticationError error: Error) -> Bool {
        switch error.asAFError {
        case .requestRetryFailed(let retryError, _):
            return retryError.asAFError?.responseCode == 401
        case .responseValidationFailed(let reason):
            switch reason {
            case .unacceptableStatusCode(let code):
                return code == 401
            default:
                return false
            }
        default:
            return false
        }
    }
    
    func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: JWTCredential) -> Bool {
        guard let token = credential.token else { return true }
        return urlRequest.headers.contains(.authorization(bearerToken: token.value))
    }
}

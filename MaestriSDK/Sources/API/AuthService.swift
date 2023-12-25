//
//  AuthService.swift
//  Created by Vitaliy Shevtsov on 4/4/23.
//

import Foundation
import Dependencies
import KeychainAccess

import AuthenticationServices
import Alamofire
import DTOs

//MARK: - Protocol

public protocol IAuthService {
    func authWithApple(data: ASAuthorization) async throws -> User.Responses.Full
    
    func authWithAnonymus() async throws -> User.Responses.Full
    
    /// Post /logout
    /// Выходит их учётной записи
    func logout() async throws
}

//MARK: - Dependency Values

public extension DependencyValues {
    
    var authService: any IAuthService {
        get { self[AuthServiceKey.self] }
        set { self[AuthServiceKey.self] = newValue }
    }
    
    enum AuthServiceKey: DependencyKey {
        public static let liveValue: IAuthService = AuthService()
    }
}

//MARK: - Live

public final class AuthService: IAuthService {
            
    //MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.decoderService) var decoderService
    @Dependency(\.tokenStorageService) var tokenStorageService
    
    public func authWithApple(data: ASAuthorization) async throws -> User.Responses.Full {
        guard let appleIDCredential = data.credential as? ASAuthorizationAppleIDCredential,
              let identityToken = appleIDCredential.identityToken,
              let appleToken = String(data: identityToken, encoding: .utf8) else {
            throw AFError.explicitlyCancelled
        }
        let userIdentifier = appleIDCredential.user
        checkUser(userID: userIdentifier)
        
        let parameters = Auth.Parameters.AppleToken(
            token: appleToken,
            firstName: appleIDCredential.fullName?.givenName,
            lastName: appleIDCredential.fullName?.familyName
        )
        let value = try await requestsService
            .request(
                path: "/v1/auth/apple",
                method: .post,
                parameters: parameters
            )
            .serializingDecodable(Auth.Responses.Full.self, decoder: decoderService.jsonDecoder)
            .value

        tokenStorageService.update(token: value.token)
        return value.user
    }
    
    //TODO: Vitalik Anonymus метод по идее не нужен
    public func authWithAnonymus() async throws -> User.Responses.Full {
        let value = try await requestsService
            .request(
                path: "/v1/auth/apple/sldkmvlsdkmclkmlkmsd",
                method: .post,
                parameters: ["token":"sldkmsdf"]
            )
            .serializingDecodable(Auth.Responses.Full.self, decoder: decoderService.jsonDecoder)
            .value
        tokenStorageService.update(token: value.token)
        return value.user
    }
    
    public func logout() async throws {
        let _ = try await requestsService
            .request(
                path: "/v1/logout",
                method: .post
            )
            .serializingDecodable(Empty.self)
            .value
        tokenStorageService.update(token: nil)
    }
}

//MARK: Private

private extension AuthService {
    
    func checkUser(userID: String) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userID) {  (credentialState, error) in
            switch credentialState {
            case .revoked:
                // The Apple ID credential is revoked.
                print("revoked")
                break
            case .authorized:
                // The Apple ID credential is valid.
                print("authorized")
                break
            case .notFound:
                // No credential was found, so show the sign-in UI.
                print("notFound")
                break
            case .transferred:
                // No credential was found, so show the sign-in UI.
                print("transferred")
                break
            @unknown default:
                print("default")
                break
            }
        }
    }
}

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

// MARK: - Protocol

public protocol IAuthService {
    func authWithApple(data: ASAuthorization) async throws -> User.Responses.Full
    
    func authWithAnonymus(token: String) async throws -> User.Responses.Full
    
    /// Post /logout
    /// Выходит их учётной записи
    func logout() async throws
}

// MARK: - Dependency Values

public extension DependencyValues {
    
    var authService: any IAuthService {
        get { self[AuthServiceKey.self] }
        set { self[AuthServiceKey.self] = newValue }
    }
    
    enum AuthServiceKey: DependencyKey {
        public static let liveValue: IAuthService = AuthService()
    }
}

// MARK: - Live

struct AuthService: IAuthService {
            
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.coderService) var coderService
    @Dependency(\.secureStorageService) var secureStorageService
    
    public func authWithApple(data: ASAuthorization) async throws -> User.Responses.Full {
        guard let appleIDCredential = data.credential as? ASAuthorizationAppleIDCredential,
              let identityToken = appleIDCredential.identityToken,
              let appleToken = String(data: identityToken, encoding: .utf8) else {
            throw AFError.explicitlyCancelled
        }
        try await checkUser(userID: appleIDCredential.user)
        
        let parameters = Auth.Parameters.AppleToken(
            token: appleToken,
            firstName: appleIDCredential.fullName?.givenName,
            lastName: appleIDCredential.fullName?.familyName
        )
        let value = try await requestsService
            .request(
                path: "/v1/auth/apple",
                method: .post,
                parameters: parameters,
                requestType: .session
            )
            .serializingDecodable(Auth.Responses.Full.self, decoder: coderService.decoder)
            .value

        secureStorageService.setAccess(token: value.accessToken)
        secureStorageService.setRefresh(token: value.refreshToken)
        return value.user
    }
    
    public func logout() async throws {
        _ = try await requestsService
            .request(
                path: "/v1/logout",
                method: .post,
                requestType: .session
            )
            .serializingDecodable(Empty.self)
            .value
        secureStorageService.setAccess(token: nil)
        secureStorageService.setRefresh(token: nil)
    }
}

extension AuthService {
    
    @available(*, deprecated, message: "Использовать только для тестирования")
    public func authWithAnonymus(token: String) async throws -> User.Responses.Full {
        let value = try await requestsService
            .request(
                path: "/v1/auth/test/\(token)",
                method: .post,
                parameters: ["token": "sldkmsdf"],
                requestType: .session
            )
            .serializingDecodable(Auth.Responses.Full.self, decoder: coderService.decoder)
            .value
        secureStorageService.setAccess(token: value.accessToken)
        secureStorageService.setRefresh(token: value.refreshToken)
        return value.user
    }
}

// MARK: Private

private extension AuthService {
    
    func checkUser(userID: String) async throws {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let credentialState = try await appleIDProvider.credentialState(forUserID: userID)
        switch credentialState {
        case .revoked:
            // The Apple ID credential is revoked.
            break
        case .authorized:
            // The Apple ID credential is valid.
            break
        case .notFound:
            // No credential was found, so show the sign-in UI.
            break
        case .transferred:
            // No credential was found, so show the sign-in UI.
            break
        @unknown default:
            break
        }
    }
}

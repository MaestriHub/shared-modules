//
//  UsersService.swift
//  Created by Vitaliy Shevtsov on 3/29/23.
//

import Foundation
import Alamofire
import Dependencies
import DTOs

public enum UserConstants {
    public static let anonymousNickname = "Anonymous"
}

// MARK: - Protocol

public protocol IUsersService {
    
    /// Post /users/professional
    func createProfessional(parameters: Professional.Parameters.Create) async throws -> User.Responses.Full
    
    /// Post /users/customer
    func createCustomer(parameters: Customer.Parameters.Registration) async throws -> User.Responses.Full
    
    /// Get /users
    func user() async throws -> User.Responses.Full
    
    /// Put /users
    func update(parameters: User.Parameters.Patch) async throws -> User.Responses.Full
    
    /// Delete /users
    func delete() async throws
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var usersService: any IUsersService {
        get { self[UsersServiceKey.self] }
        set { self[UsersServiceKey.self] = newValue }
    }
    
    enum UsersServiceKey: DependencyKey {
        public static let liveValue: IUsersService = UsersService()
    }
}

// MARK: - Live

struct UsersService: IUsersService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.coderService) var coderService
    @Dependency(\.secureStorageService) var secureStorageService
    
    // MARK: - Methods
    
    func createProfessional(parameters: Professional.Parameters.Create) async throws -> User.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/users/professional",
                method: .post,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(User.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    func createCustomer(parameters: Customer.Parameters.Registration) async throws -> User.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/users/customer",
                method: .post,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(User.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    func user() async throws -> User.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/users",
                method: .get,
                requestType: .other
            )
            .serializingDecodable(User.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    func update(parameters: User.Parameters.Patch) async throws -> User.Responses.Full {
        return try await requestsService
            .request(
                path: "/v1/users",
                method: .put,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(User.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    func delete() async throws {
        _ = try await requestsService
            .request(
                path: "/v1/users",
                method: .delete,
                requestType: .other
            )
            .serializingDecodable(Empty.self)
            .value
        secureStorageService.setRefresh(token: nil)
    }
}

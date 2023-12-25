//
//  UsersService.swift
//  Created by Vitaliy Shevtsov on 3/29/23.
//

import Foundation
import Alamofire
import Dependencies
import DTOs

//MARK: - Protocol

public protocol IUsersService {
    
    /// Post /users/switch
    func switchMode(parameters: User.Parameters.Switch) async throws
    
    /// Post /users/professional
    func createProfessional(parameters: User.Parameters.CreateProfessional) async throws -> User.Responses.Full
    
    /// Post /users/customer
    func createCustomer(parameters: User.Parameters.CreateCustomer) async throws -> User.Responses.Full
    
    /// Get /users
    func user() async throws -> User.Responses.Full
    
    /// Put /users
    func update(parameters: User.Parameters.Patch) async throws -> User.Responses.Full
    
    /// Delete /users
    func delete() async throws
}

//MARK: - DependencyValues

public extension DependencyValues {
    
    var usersService: any IUsersService {
        get { self[UsersServiceKey.self] }
        set { self[UsersServiceKey.self] = newValue }
    }
    
    enum UsersServiceKey: DependencyKey {
        public static let liveValue: IUsersService = UsersService()
    }
}

//MARK: - Live

final class UsersService: IUsersService {
    
    //MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.decoderService) var decoderService
    @Dependency(\.tokenStorageService) var tokenStorageService
    
    //MARK: - Methods
    
    func switchMode(parameters: User.Parameters.Switch) async throws {
        let _ = try await requestsService
            .request(
                path: "/v1/users/switch",
                method: .post,
                parameters: parameters
            )
            .serializingDecodable(Empty.self, emptyResponseCodes: [200])
            .value
    }
    
    func createProfessional(parameters: User.Parameters.CreateProfessional) async throws -> User.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/users/professional",
                method: .get,
                parameters: parameters
            )
            .serializingDecodable(User.Responses.Full.self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    func createCustomer(parameters: User.Parameters.CreateCustomer) async throws -> User.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/users/customer",
                method: .get,
                parameters: parameters
            )
            .serializingDecodable(User.Responses.Full.self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    func user() async throws -> User.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/users",
                method: .get
            )
            .serializingDecodable(User.Responses.Full.self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    func update(parameters: User.Parameters.Patch) async throws -> User.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/users",
                method: .put,
                parameters: parameters
            )
            .serializingDecodable(User.Responses.Full.self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    func delete() async throws {
        let _ = try await requestsService
            .request(
                path: "/v1/users",
                method: .delete
            )
            .serializingDecodable(Empty.self)
            .value
        tokenStorageService.update(token: nil)
    }
}

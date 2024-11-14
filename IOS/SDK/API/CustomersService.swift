//
//  CustomersService.swift
//  Created by Vitaliy Shevtsov on 3/29/23.
//

import Foundation
import Alamofire
import Dependencies
import DTOs

public protocol ICustomersService {
    
    /// GET /customers
    func customers(parameters: Customer.Parameters.Retrieve) async throws -> [Customer.Responses.Partial]
    
    /// GET /customers/:id
    func customer(id: UUID) async throws -> Customer.Responses.Full
    
    /// Create /customers
    func create(parameters: Customer.Parameters.Create) async throws -> Customer.Responses.Partial
    
    /// Invite /customers
    func inviteHandler(id: UUID, parameters: Customer.Parameters.HandleInvite) async throws -> HandleInvite
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var customersService: any ICustomersService {
        get { self[CustomersServiceKey.self] }
        set { self[CustomersServiceKey.self] = newValue }
    }
    
    enum CustomersServiceKey: DependencyKey {
        public static let liveValue: ICustomersService = CustomersService()
    }
}

// MARK: - Live

struct CustomersService: ICustomersService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.coderService) var coderService
    
    // MARK: - Methods
    
    public func create(parameters: Customer.Parameters.Create) async throws -> Customer.Responses.Partial {
        try await requestsService
            .request(
                path: "v1/customers",
                method: .post,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Customer.Responses.Partial.self, decoder: coderService.decoder)
            .value
    }
    
    public func customers(parameters: Customer.Parameters.Retrieve) async throws -> [Customer.Responses.Partial] {
        try await requestsService
            .request(
                path: "v1/customers",
                method: .get,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable([Customer.Responses.Partial].self, decoder: coderService.decoder)
            .value
    }
    
    public func customer(id: UUID) async throws -> Customer.Responses.Full {
        try await requestsService
            .request(
                path: "v1/customers/\(id)",
                method: .get,
                requestType: .other
            )
            .serializingDecodable(Customer.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    public func inviteHandler(id: UUID, parameters: Customer.Parameters.HandleInvite) async throws -> HandleInvite {
        try await requestsService
            .request(
                path: "v1/customers/\(id)",
                method: .put,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(HandleInvite.self, decoder: coderService.decoder)
            .value
    }
}

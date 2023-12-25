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
    func contacts(parameters: Customer.Parameters.Retrieve) async throws -> [Customer.Responses.Partial]
    
    /// Put /customers
    func update(parameters: Customer.Parameters.Patch) async throws -> Customer.Responses.Partial
}

//MARK: - DependencyValues

public extension DependencyValues {
    
    var customersService: any ICustomersService {
        get { self[CustomersServiceKey.self] }
        set { self[CustomersServiceKey.self] = newValue }
    }
    
    enum CustomersServiceKey: DependencyKey {
        public static let liveValue: ICustomersService = CustomersService()
    }
}

//MARK: - Live

public final class CustomersService: ICustomersService {
    
    //MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.decoderService) var decoderService
    
    //MARK: - Methods
    
    public func contacts(parameters: Customer.Parameters.Retrieve) async throws -> [Customer.Responses.Partial] {
        try await requestsService
            .request(
                path: "v1/customers",
                method: .get,
                parameters: parameters
            )
            .serializingDecodable([Customer.Responses.Partial].self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func update(parameters: Customer.Parameters.Patch) async throws -> Customer.Responses.Partial {
        try await requestsService
            .request(
                path: "v1/customers",
                method: .post,
                parameters: parameters
            )
            .serializingDecodable(Customer.Responses.Partial.self, decoder: decoderService.jsonDecoder)
            .value
    }
}

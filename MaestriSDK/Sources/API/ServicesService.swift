//
//  ServicesService.swift
//  Created by Vitaliy Shevtsov on 3/29/23.
//  Copyright © 2023 Maestri Hub. All rights reserved.
//

import Foundation
import Alamofire
import Dependencies
import DTOs

//MARK: - Protocol

public protocol IServicesService {
    
    /// Get /services
    func services(parameters: Service.Parameters.Retrieve) async throws -> [Service.Responses.Partial]
    
    /// Post /services
    func create(parameters: Service.Parameters.Create) async throws -> Service.Responses.Full
    
    /// Get /services/:id
    func procedure(id: UUID) async throws -> Service.Responses.Full
    
    /// Put /services/:id
    func update(id: UUID, parameters: Service.Parameters.Patch) async throws -> Service.Responses.Full
    
    /// Delete /services/:id
    func delete(id: UUID) async throws
}

//MARK: - DependencyValues

public extension DependencyValues {
    
    var servicesService: any IServicesService {
        get { self[ServicesServiceKey.self] }
        set { self[ServicesServiceKey.self] = newValue }
    }
    
    enum ServicesServiceKey: DependencyKey {
        public static let liveValue: IServicesService = ServicesService() //ServicesServiceMock()//
    }
}

//MARK: - Live

public final class ServicesService: IServicesService {

    //MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.decoderService) var decoderService
    
    //MARK: - Methods
    
    public func services(parameters: Service.Parameters.Retrieve) async throws -> [Service.Responses.Partial] {
        try await requestsService
            .request(
                path: "/v1/services",
                method: .get,
                parameters: parameters
            )
            .serializingDecodable([Service.Responses.Partial].self)
            .value
    }
    
    public func create(parameters: Service.Parameters.Create) async throws -> Service.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/services",
                method: .post,
                parameters: parameters
            )
            .serializingDecodable(Service.Responses.Full.self)
            .value
    }
    
    public func procedure(id: UUID) async throws -> Service.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/services/\(id)",
                method: .get
            )
            .serializingDecodable(Service.Responses.Full.self)
            .value
    }
    
    public func update(id: UUID, parameters: Service.Parameters.Patch) async throws -> Service.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/services/\(id)",
                method: .put,
                parameters: parameters
            )
            .serializingDecodable(Service.Responses.Full.self)
            .value
    }
    
    public func delete(id: UUID) async throws {
        let _ = try await requestsService
            .request(
                path: "/v1/services/\(id)",
                method: .delete
            )
            .serializingDecodable(Empty.self)
            .value
    }
}

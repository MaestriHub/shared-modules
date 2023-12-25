//
//  SalonsService.swift
//  Created by Vitaliy Shevtsov on 3/29/23.
//

import Foundation
import Alamofire
import Dependencies
import DTOs

//MARK: - Protocol

public protocol ISalonsService {

    /// GET /salons/workshops
    /// В которых он либо работает либо владельцем которых является
    func workshops() async throws -> [Salon.Responses.Partial]
    
    /// Get /salons/:id
    func salon(id: UUID) async throws -> Salon.Responses.Full

    /// Post /salons
    func create(parameters: Salon.Parameters.Create) async throws -> Salon.Responses.Full
    
    /// Put /salons
    func update(id: UUID, parameters: Salon.Parameters.Patch) async throws -> Salon.Responses.Full
    
    /// Delete /salons
    func delete(id: UUID) async throws
}

//MARK: - DependencyValues

public extension DependencyValues {
    
    var salonsService: any ISalonsService {
        get { self[SalonsServiceKey.self] }
        set { self[SalonsServiceKey.self] = newValue }
    }
    
    enum SalonsServiceKey: DependencyKey {
        public static let liveValue: ISalonsService = SalonsService()
    }
}

//MARK: - Live

public final class SalonsService: ISalonsService {
    
    //MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.decoderService) var decoderService
    
    //MARK: - Methods
    
    public func workshops() async throws -> [Salon.Responses.Partial] {
        try await requestsService
            .request(
                path: "/v1/salons/workshops",
                method: .get
            )
            .serializingDecodable([Salon.Responses.Partial].self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func create(parameters: Salon.Parameters.Create) async throws -> Salon.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/salons",
                method: .post,
                parameters: parameters
            )
            .serializingDecodable(Salon.Responses.Full.self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func salon(id: UUID) async throws -> Salon.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/salons/\(id)",
                method: .get
            )
            .serializingDecodable(Salon.Responses.Full.self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func update(id: UUID, parameters: Salon.Parameters.Patch) async throws -> Salon.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/salons/\(id)",
                method: .get,
                parameters: parameters
            )
            .serializingDecodable(Salon.Responses.Full.self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func delete(id: UUID) async throws {
        let _ = try await requestsService
            .request(
                path: "/v1/salons/\(id)",
                method: .delete
            )
            .serializingDecodable(Empty.self)
            .value
    }
}

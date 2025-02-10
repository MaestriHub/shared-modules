import Foundation
import Alamofire
import Dependencies
import DTOs

// MARK: - Protocol

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
    
    /// Activate /salons
    func activate(id: UUID) async throws -> Salon.Responses.Full
    
    /// Deactivate /salons
    func deactivate(id: UUID) async throws -> Salon.Responses.Full
    
    /// Delete /salons
    func delete(id: UUID) async throws
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var salonsService: any ISalonsService {
        get { self[SalonsServiceKey.self] }
        set { self[SalonsServiceKey.self] = newValue }
    }
    
    enum SalonsServiceKey: DependencyKey {
        public static var liveValue: ISalonsService = SalonsService()
    }
}

// MARK: - Live

struct SalonsService: ISalonsService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    
    // MARK: - Methods
    
    func workshops() async throws -> [Salon.Responses.Partial] {
        try await requestsService
            .request(
                path: "/v1/salons/workshops",
                method: .get
            )
            .serializingValue([Salon.Responses.Partial].self)
    }
    
    func create(parameters: Salon.Parameters.Create) async throws -> Salon.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/salons",
                method: .post,
                parameters: parameters
            )
            .serializingValue(Salon.Responses.Full.self)
    }
    
    func salon(id: UUID) async throws -> Salon.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/salons/\(id)",
                method: .get
            )
            .serializingValue(Salon.Responses.Full.self)
    }
    
    func update(id: UUID, parameters: Salon.Parameters.Patch) async throws -> Salon.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/salons/\(id)",
                method: .put,
                parameters: parameters
            )
            .serializingValue(Salon.Responses.Full.self)
    }
    
    func activate(id: UUID) async throws -> Salon.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/salons/\(id)/activate",
                method: .put
            )
            .serializingValue(Salon.Responses.Full.self)
    }
    
    func deactivate(id: UUID) async throws -> Salon.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/salons/\(id)/deactivate",
                method: .put
            )
            .serializingValue(Salon.Responses.Full.self)
    }
    
    func delete(id: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/salons/\(id)",
                method: .delete
            )
            .serializingValue(Empty.self)
    }
}

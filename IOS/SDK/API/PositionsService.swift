import Foundation
import Alamofire
import Dependencies
import DTOs

// MARK: - Protocol

public protocol IPositionsService {
    
    /// GET /position
    func positions(salonId: UUID) async throws -> [Position.Responses.Full]
    
    /// Get /position/:id
    func position(id: UUID) async throws -> Position.Responses.Full
    
    /// Post /positions
    func create(salonId: UUID, parameters: Position.Parameters.Create) async throws -> Position.Responses.Full
    
    /// Put /positions
    func update(id: UUID, parameters: Position.Parameters.Patch) async throws -> Position.Responses.Full
    
    /// Delete /positions
    func delete(id: UUID) async throws
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var positionsService: any IPositionsService {
        get { self[PositionsServiceKey.self] }
        set { self[PositionsServiceKey.self] = newValue }
    }
    
    enum PositionsServiceKey: DependencyKey {
        public static var liveValue: IPositionsService = PositionsService()
    }
}

// MARK: - Live

struct PositionsService: IPositionsService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    
    // MARK: - Methods
    func positions(salonId: UUID) async throws -> [Position.Responses.Full] {
        try await requestsService
            .request(
                path: "/v1/positions/salon/\(salonId)",
                method: .get
            )
            .serializingValue([Position.Responses.Full].self)
    }
    
    func create(salonId: UUID, parameters: Position.Parameters.Create) async throws -> Position.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/positions/salon/\(salonId)",
                method: .post,
                parameters: parameters
            )
            .serializingValue(Position.Responses.Full.self)
    }
    
    func position(id: UUID) async throws -> Position.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/positions/\(id)",
                method: .get
            )
            .serializingValue(Position.Responses.Full.self)
    }
    
    func update(id: UUID, parameters: Position.Parameters.Patch) async throws -> Position.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/positions/\(id)",
                method: .put,
                parameters: parameters
            )
            .serializingValue(Position.Responses.Full.self)
    }
    
    func delete(id: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/positions/\(id)",
                method: .delete
            )
            .serializingValue(Empty.self)
    }
}

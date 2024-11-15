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
//        public static let liveValue: IPositionsService = {
//            @Dependency(\.toggleService) var toggleService
//            return toggleService.isActive(.positionsServiceMocks) ? PositionsServiceMock() : PositionsService()
//        }()
    }
}

// MARK: - Live

struct PositionsService: IPositionsService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.coderService) var coderService
    
    // MARK: - Methods
    public func positions(salonId: UUID) async throws -> [Position.Responses.Full] {
        try await requestsService
            .request(
                path: "/v1/positions/salon/\(salonId)",
                method: .get,
                requestType: .other
            )
            .serializingDecodable([Position.Responses.Full].self, decoder: coderService.decoder)
            .value
    }
    
    public func create(salonId: UUID, parameters: Position.Parameters.Create) async throws -> Position.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/positions/salon/\(salonId)",
                method: .post,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Position.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    public func position(id: UUID) async throws -> Position.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/positions/\(id)",
                method: .get,
                requestType: .other
            )
            .serializingDecodable(Position.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    public func update(id: UUID, parameters: Position.Parameters.Patch) async throws -> Position.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/positions/\(id)",
                method: .put,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Position.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    public func delete(id: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/positions/\(id)",
                method: .delete,
                requestType: .other
            )
            .serializingDecodable(Empty.self)
            .value
    }
}

final class PositionsServiceMock: IPositionsService {
    
    func positions(salonId: UUID) async throws -> [Position.Responses.Full] {
        [
            Position.Responses.Full(
                id: UUID(),
                title: "Position Mock",
                permissions: .all,
                salary: Salary.Responses.Rules.Full(percent: nil, grid: nil, wage: nil)
            ),
            Position.Responses.Full(
                id: UUID(),
                title: "Position Mock 2",
                permissions: .all,
                salary: Salary.Responses.Rules.Full(percent: nil, grid: nil, wage: nil)
            ),
            Position.Responses.Full(
                id: UUID(),
                title: "Position Mock 3",
                permissions: .all,
                salary: Salary.Responses.Rules.Full(percent: nil, grid: nil, wage: nil)
            )
        ]
    }
    
    func position(id: UUID) async throws -> Position.Responses.Full {
        try await Task.sleep(for: .seconds(10))
        return Position.Responses.Full(
            id: UUID(),
            title: "Position Mock",
            permissions: .all,
            salary: Salary.Responses.Rules.Full(percent: nil, grid: nil, wage: nil)
        )
    }
    
    func create(salonId: UUID, parameters: Position.Parameters.Create) async throws -> Position.Responses.Full {
        return Position.Responses.Full(
            id: UUID(),
            title: "Position Mock Create",
            permissions: .all,
            salary: Salary.Responses.Rules.Full(percent: nil, grid: nil, wage: nil)
        )
    }
    
    func update(id: UUID, parameters: Position.Parameters.Patch) async throws -> Position.Responses.Full {
        return Position.Responses.Full(
            id: UUID(),
            title: "Position Mock Update",
            permissions: .all,
            salary: Salary.Responses.Rules.Full(percent: nil, grid: nil, wage: nil)
        )
    }
    
    func delete(id: UUID) async throws {
        try await Task.sleep(for: .seconds(10))
    }
}

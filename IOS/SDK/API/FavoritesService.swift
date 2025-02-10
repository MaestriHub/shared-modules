import Foundation
import Alamofire
import Dependencies
import DTOs

// MARK: - Protocol

public protocol IFavoritesService {
    
    /// Get /favorites/:id
    func favorites() async throws -> [Salon.Responses.Partial]
    
    /// Get /favorites/:id/add
    func add(id: UUID) async throws
    
    /// Get /favorites/:id/remove
    func remove(id: UUID) async throws
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var favoritesService: any IFavoritesService {
        get { self[FavoritesServiceKey.self] }
        set { self[FavoritesServiceKey.self] = newValue }
    }
    
    enum FavoritesServiceKey: DependencyKey {
        public static var liveValue: IFavoritesService = FavoritesService()
    }
}

// MARK: - Live

struct FavoritesService: IFavoritesService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    
    // MARK: - Methods
    
    func favorites() async throws -> [Salon.Responses.Partial] {
        try await requestsService
            .request(
                path: "/v1/favorites",
                method: .get
            )
            .serializingValue([Salon.Responses.Partial].self)
    }
    
    func add(id: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/favorites/\(id)/add",
                method: .put
            )
            .serializingValue(Empty.self, emptyResponseCodes: [200])
    }
    
    func remove(id: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/favorites/\(id)/remove",
                method: .put
            )
            .serializingValue(Empty.self, emptyResponseCodes: [200])
    }
}

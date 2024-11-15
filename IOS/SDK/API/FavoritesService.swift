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
//        public static let liveValue: IFavoritesService = {
//            @Dependency(\.toggleService) var toggleService
//            return toggleService.isActive(.favoritesMocks) ? FavoritesServiceMock() : FavoritesService()
//        }()
    }
}

// MARK: - Live

struct FavoritesService: IFavoritesService {

    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.coderService) var coderService
    
    // MARK: - Methods
    
    public func favorites() async throws -> [Salon.Responses.Partial] {
        try await requestsService
            .request(
                path: "/v1/favorites",
                method: .get,
                requestType: .other
            )
            .serializingDecodable([Salon.Responses.Partial].self, decoder: coderService.decoder)
            .value
    }
    
    public func add(id: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/favorites/\(id)/add",
                method: .put,
                requestType: .other
            )
            .serializingDecodable(Empty.self, emptyResponseCodes: [200])
            .value
    }
    
    public func remove(id: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/favorites/\(id)/remove",
                method: .put,
                requestType: .other
            )
            .serializingDecodable(Empty.self, emptyResponseCodes: [200])
            .value
    }
}

final class FavoritesServiceMock: IFavoritesService {
    func favorites() async throws -> [DTOs.Salon.Responses.Partial] {
        return [.init(id: UUID(),
                      name: "SalonName",
                      type: .individual,
                      address: .init(
                        address: "Belarus",
                        city: "Pushcha",
                        country: "BLR",
                        latitude: 52.321,
                        longitude: 32.123
                      ),
                      isFavorite: true)
        ]
    }
    
    func add(id: UUID) async throws {
        try await Task.sleep(for: .seconds(3))
    }
    
    func remove(id: UUID) async throws {
        try await Task.sleep(for: .seconds(3))
    }
}

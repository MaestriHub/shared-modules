//
//  FavoritesService.swift
//  Created by Vitaliy Shevtsov on 3/29/23.
//

import Foundation
import Alamofire
import Dependencies
import DTOs

//MARK: - Protocol

public protocol IFavoritesService {
     
    /// Get /favorites/:id
    func favorites() async throws -> [Salon.Responses.Partial]
    
    /// Get /favorites/:id/add
    func add(id: UUID) async throws
    
    /// Get /favorites/:id/remove
    func remove(id: UUID) async throws
}

//MARK: - DependencyValues

public extension DependencyValues {
    
    var favoritesService: any IFavoritesService {
        get { self[FavoritesServiceKey.self] }
        set { self[FavoritesServiceKey.self] = newValue }
    }
    
    enum FavoritesServiceKey: DependencyKey {
        public static let liveValue: IFavoritesService = FavoritesService() //FavoritesServiceMock()
    }
}

//MARK: - Live

public final class FavoritesService: IFavoritesService {

    //MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.decoderService) var decoderService
    
    //MARK: - Methods
    
    public func favorites() async throws -> [Salon.Responses.Partial] {
        try await requestsService
            .request(
                path: "/v1/favorites",
                method: .get
            )
            .serializingDecodable([Salon.Responses.Partial].self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func add(id: UUID) async throws {
        let _ = try await requestsService
            .request(
                path: "/v1/favorites/\(id)/add",
                method: .get
            )
            .serializingDecodable(Empty.self, emptyResponseCodes: [200])
            .value
    }
    
    public func remove(id: UUID) async throws {
        let _ = try await requestsService
            .request(
                path: "/v1/favorites/\(id)/remove",
                method: .get
            )
            .serializingDecodable(Empty.self, emptyResponseCodes: [200])
            .value
    }
}

//
//  SearchService.swift
//  Created by Vitaliy Shevtsov on 7/17/23.
//  Copyright © 2023 Maestri Hub. All rights reserved.
//

import Foundation
import Alamofire
import Dependencies
import DTOs
import CoreLocation

// MARK: - Protocol

public protocol ISearchService {
    
    /// Get /search
    func search(parameters: Search.Parameters.Retrieve) async throws -> Search.Responses.Full
    
    var isLoadingPublished: PublishedAction<Bool> { get }
    var searchResultPublished: PublishedAction<Search.Responses.Full> { get }
    var searchCenterPublished: PublishedAction<CLLocationCoordinate2D> { get }
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var searchService: any ISearchService {
        get { self[SearchServiceKey.self] }
        set { self[SearchServiceKey.self] = newValue }
    }
    
    enum SearchServiceKey: DependencyKey {
        public static let liveValue: ISearchService = {
            @Dependency(\.toggleService) var toggleService
            return toggleService.isActive(.searchServiceMocks) ? SearchServiceMock() : SearchService()
        }()
    }
}

// MARK: - Live

struct SearchService: ISearchService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.coderService) var coderService
    
    public var searchResultPublished = PublishedAction<Search.Responses.Full>()
    public var isLoadingPublished = PublishedAction<Bool>()
    public var searchCenterPublished = PublishedAction<CLLocationCoordinate2D>()
    
    // MARK: - Methods
    
    public func search(parameters: Search.Parameters.Retrieve) async throws -> Search.Responses.Full {
        isLoadingPublished.send(true)
        let result = try await requestsService
            .request(
                path: "/v1/search",
                method: .get,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Search.Responses.Full.self, decoder: coderService.decoder)
            .value
        searchResultPublished.send(result)
        isLoadingPublished.send(false)
        return result
    }
}

// MARK: - Mock

struct SearchServiceMock {
    static var salons = Search.Responses.Full(
        suggests: [], salons: [
            Salon.Responses.Partial(
                id: UUID(),
                name: "Glamorous Touch",
                type: .chain,
                address: Address(
                    address: "789 Hollywood Blvd",
                    city: "Los Angeles",
                    country: "USA",
                    latitude: 34.10127,
                    longitude: -118.3254
                ),
                isFavorite: true
            ),
            Salon.Responses.Partial(
                id: UUID(),
                name: "Chic & Classy",
                type: .chain,
                address: Address(
                    address: "456 Sunset Blvd",
                    city: "Los Angeles",
                    country: "USA",
                    latitude: 34.1012,
                    longitude: -118.3254
                ),
                isFavorite: true
            ),
            Salon.Responses.Partial(
                id: UUID(),
                name: "Luxe Beauty Lounge",
                type: .chain,
                logo: URL(string: "https://www.sostav.ru/images/news/2022/07/15/7xnzppui.jpg"),
                address: Address(
                    address: "123 Melrose Ave",
                    city: "Los Angeles",
                    country: "USA",
                    latitude: 34.0841,
                    longitude: -118.3338
                ),
                isFavorite: true
            ),
            Salon.Responses.Partial(
                id: UUID(),
                name: "Glamour Haven",
                type: .chain,
                logo: URL(string: "https://www.sostav.ru/images/news/2022/07/15/7xnzppui.jpg"),
                address: Address(
                    address: "987 Hollywood Blvd",
                    city: "Los Angeles",
                    country: "USA",
                    latitude: 34.1003,
                    longitude: -118.3274
                ),
                isFavorite: false
            ),
            Salon.Responses.Partial(
                id: UUID(),
                name: "Sleek Style Studio",
                type: .chain,
                address: Address(
                    address: "321 Sunset Blvd",
                    city: "Los Angeles",
                    country: "USA",
                    latitude: 34.0998,
                    longitude: -118.3225
                ),
                isFavorite: false
            ),
            Salon.Responses.Partial(
                id: UUID(),
                name: "Elegant Edge Salon",
                type: .chain,
                address: Address(
                    address: "654 Hollywood Blvd",
                    city: "Los Angeles",
                    country: "USA",
                    latitude: 34.0991,
                    longitude: -118.3237
                ),
                isFavorite: false
            ),
            Salon.Responses.Partial(
                id: UUID(),
                name: "Classy Cuts & Colors",
                type: .chain,
                address: Address(
                    address: "111 Melrose Ave",
                    city: "Los Angeles",
                    country: "USA",
                    latitude: 34.0852,
                    longitude: -118.3357
                ),
                isFavorite: false
            ),
            Salon.Responses.Partial(
                id: UUID(),
                name: "Posh Pampering Palace",
                type: .chain,
                address: Address(
                    address: "222 Sunset Blvd",
                    city: "Los Angeles",
                    country: "USA",
                    latitude: 34.0974,
                    longitude: -118.3246
                ),
                isFavorite: false
            ),
            Salon.Responses.Partial(
                id: UUID(),
                name: "Chic Beauty Bar",
                type: .chain,
                address: Address(
                    address: "333 Hollywood Blvd",
                    city: "Los Angeles",
                    country: "USA",
                    latitude: 34.0987,
                    longitude: -118.3263
                ),
                isFavorite: false
            ),
            Salon.Responses.Partial(
                id: UUID(),
                name: "Glamour Zone",
                type: .chain,
                address: Address(
                    address: "444 Melrose Ave",
                    city: "Los Angeles",
                    country: "USA",
                    latitude: 34.0863,
                    longitude: -118.3344
                ),
                isFavorite: false
            ),
            Salon.Responses.Partial(
                id: UUID(),
                name: "Divine Beauty Lounge",
                type: .chain,
                address: Address(
                    address: "555 Sunset Blvd",
                    city: "Los Angeles",
                    country: "USA",
                    latitude: 34.0989,
                    longitude: -118.3207
                ),
                isFavorite: true
            ),
            Salon.Responses.Partial(
                id: UUID(),
                name: "Sassy Style Studio",
                type: .chain,
                address: Address(
                    address: "666 Hollywood Blvd",
                    city: "Los Angeles",
                    country: "USA",
                    latitude: 34.1007,
                    longitude: -118.3281
                ),
                isFavorite: true
            ),
            Salon.Responses.Partial(
                id: UUID(),
                name: "Glamorous Glow",
                type: .chain,
                address: Address(
                    address: "777 Melrose Ave",
                    city: "Los Angeles",
                    country: "USA",
                    latitude: 34.0857,
                    longitude: -118.3320
                ),
                isFavorite: false
            ),
            Salon.Responses.Partial(
                id: UUID(),
                name: "Chic Charm Salon",
                type: .chain,
                address: Address(
                    address: "888 Sunset Blvd",
                    city: "Los Angeles",
                    country: "USA",
                    latitude: 34.0971,
                    longitude: -118.3214
                ),
                isFavorite: false
            ),
            Salon.Responses.Partial(
                id: UUID(),
                name: "Elegant Elements",
                type: .chain,
                address: Address(
                    address: "999 Hollywood Blvd",
                    city: "Los Angeles",
                    country: "USA",
                    latitude: 34.1009,
                    longitude: -118.3249
                ),
                isFavorite: false
            ),
            Salon.Responses.Partial(
                id: UUID(),
                name: "Glowing Beauty Bar",
                type: .chain,
                address: Address(
                    address: "1010 Melrose Ave",
                    city: "Los Angeles",
                    country: "USA",
                    latitude: 34.0868,
                    longitude: -118.3312
                ),
                isFavorite: false
            ),
            Salon.Responses.Partial(
                id: UUID(),
                name: "Radiant Reflections",
                type: .chain,
                address: Address(
                    address: "1212 Sunset Blvd",
                    city: "Los Angeles",
                    country: "USA",
                    latitude: 34.0992,
                    longitude: -118.3221
                ),
                isFavorite: false
            ),
            Salon.Responses.Partial(
                id: UUID(),
                name: "Chic & Sassy Salon",
                type: .chain,
                address: Address(
                    address: "1414 Hollywood Blvd",
                    city: "Los Angeles",
                    country: "USA",
                    latitude: 34.1001,
                    longitude: -118.3279
                ),
                isFavorite: false
            )
        ]
    )
    
    public var searchResultPublished = PublishedAction<Search.Responses.Full>()
    public var isLoadingPublished = PublishedAction<Bool>()
    public var searchCenterPublished = PublishedAction<CLLocationCoordinate2D>()
}

// MARK: - ISearchService

extension SearchServiceMock: ISearchService {
    
    public func search(parameters: DTOs.Search.Parameters.Retrieve) async throws -> DTOs.Search.Responses.Full {
        isLoadingPublished.send(true)
        searchResultPublished.send(SearchServiceMock.salons)
        isLoadingPublished.send(false)
        return SearchServiceMock.salons
    }
}

//
//  SearchService.swift
//  Created by Vitaliy Shevtsov on 7/17/23.
//  Copyright © 2023 Maestri Hub. All rights reserved.
//

import Foundation
import Alamofire
import Dependencies
import DTOs

//MARK: - Protocol

public protocol ISearchService {
    
    /// Get /search
    func search(parameters: Search.Parameters.Retrieve) async throws -> Search.Responses.Full
}

//MARK: - DependencyValues

public extension DependencyValues {
    
    var searchService: any ISearchService {
        get { self[SearchServiceKey.self] }
        set { self[SearchServiceKey.self] = newValue }
    }
    
    enum SearchServiceKey: DependencyKey {
        public static let liveValue: ISearchService = SearchService()
    }
}

//MARK: - Live

public final class SearchService: ISearchService {
    
    //MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.decoderService) var decoderService
    
    //MARK: - Methods
    
    public func search(parameters: Search.Parameters.Retrieve) async throws -> Search.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/search",
                method: .get,
                parameters: parameters
            )
            .serializingDecodable(Search.Responses.Full.self)
            .value
    }
}

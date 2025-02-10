import Foundation
import Alamofire
import Dependencies
import DTOs
import CoreLocation

// MARK: - Protocol

public protocol ISearchService {
    
    /// Get /search
    func search(parameters: Search.Parameters.Retrieve) async throws -> Search.Responses.Full
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var searchService: any ISearchService {
        get { self[SearchServiceKey.self] }
        set { self[SearchServiceKey.self] = newValue }
    }
    
    enum SearchServiceKey: DependencyKey {
        public static var liveValue: ISearchService = SearchService()
    }
}

// MARK: - Live

struct SearchService: ISearchService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    
    // MARK: - Methods
    
    func search(parameters: Search.Parameters.Retrieve) async throws -> Search.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/search",
                method: .get,
                parameters: parameters
            )
            .serializingValue(Search.Responses.Full.self)
    }
}

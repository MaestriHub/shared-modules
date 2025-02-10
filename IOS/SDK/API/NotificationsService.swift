import Foundation
import Alamofire
import Dependencies
import DTOs

// MARK: - Protocol

public protocol INoticesService {
    
    /// Get /notices
    func notices() async throws -> [Notice.Responses.Full]
    
    /// Put /notices/readed/:id
    func readed(id: UUID) async throws
    
    /// Put /notices/readed
    func readedAll() async throws
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var noticesService: any INoticesService {
        get { self[NoticesServiceKey.self] }
        set { self[NoticesServiceKey.self] = newValue }
    }
    
    enum NoticesServiceKey: DependencyKey {
        public static var liveValue: INoticesService = NoticesService()
    }
}

// MARK: - Live

struct NoticesService: INoticesService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    
    // MARK: - Methods
    
    func notices() async throws -> [Notice.Responses.Full] {
        try await requestsService
            .request(
                path: "/v1/notifications",
                method: .get
            )
            .serializingValue([Notice.Responses.Full].self)
    }
    
    func readed(id: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/notifications/readed/\(id)",
                method: .put
            )
            .serializingValue(Empty.self, emptyResponseCodes: [200])
    }
    
    func readedAll() async throws {
        _ = try await requestsService
            .request(
                path: "/v1/notifications/readed",
                method: .put
            )
            .serializingValue(Empty.self, emptyResponseCodes: [200])
    }
}

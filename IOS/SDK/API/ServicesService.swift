import Foundation
import Alamofire
import Dependencies
import DTOs

// MARK: - Protocol

public protocol IServicesService {
    
    /// Get /services
    func services(parameters: Service.Parameters.Retrieve) async throws -> [Service.Responses.Partial]
    
    /// Post /services
    func create(parameters: Service.Parameters.Create) async throws -> Service.Responses.Full
    
    /// Get /services/:id
    func service(id: UUID, parameters: Service.Parameters.RetrieveFull) async throws -> Service.Responses.Full
    
    /// Put /services/:id
    func update(id: UUID, parameters: Service.Parameters.Patch) async throws -> Service.Responses.Full
    
    /// Delete /services/:id
    func delete(id: UUID) async throws
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var servicesService: any IServicesService {
        get { self[ServicesServiceKey.self] }
        set { self[ServicesServiceKey.self] = newValue }
    }
    
    enum ServicesServiceKey: DependencyKey {
        public static var liveValue: IServicesService = ServicesService()
    }
}

// MARK: - Live

struct ServicesService: IServicesService {

    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    
    // MARK: - Methods
    
    func services(parameters: Service.Parameters.Retrieve) async throws -> [Service.Responses.Partial] {
        try await requestsService
            .request(
                path: "/v1/services",
                method: .get,
                parameters: parameters
)
            .serializingValue([Service.Responses.Partial].self)
    }
    
    func create(parameters: Service.Parameters.Create) async throws -> Service.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/services",
                method: .post,
                parameters: parameters
)
            .serializingValue(Service.Responses.Full.self)
    }
    
    func service(id: UUID, parameters: Service.Parameters.RetrieveFull) async throws -> Service.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/services/\(id)",
                method: .get,
                parameters: parameters
)
            .serializingValue(Service.Responses.Full.self)
    }
    
    func update(id: UUID, parameters: Service.Parameters.Patch) async throws -> Service.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/services/\(id)",
                method: .put,
                parameters: parameters
)
            .serializingValue(Service.Responses.Full.self)
    }
    
    func delete(id: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/services/\(id)",
                method: .delete)
            .serializingValue(Empty.self)
    }
}

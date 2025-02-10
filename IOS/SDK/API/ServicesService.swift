import Foundation
import Alamofire
import Dependencies
import DTOs

// MARK: - Protocol

public protocol IServicesService {
    
    /// Get /services
    func services(parameters: Service.Parameters.All) async throws -> Service.Responses.All
    
    /// Post /services
    func create(parameters: Service.Parameters.Create) async throws -> Service.Responses.Create
    
    /// Put /services/:id
    func update(id: UUID, parameters: Service.Parameters.Update) async throws -> Service.Responses.Update
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
    @Dependency(\.coderService) var coderService
    
    // MARK: - Methods
    
    func services(parameters: Service.Parameters.All) async throws -> Service.Responses.All {
        try await requestsService
            .request(
                path: "/v1/services",
                method: .get,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Service.Responses.All.self, decoder: coderService.decoder)
            .value
    }
    
    func create(parameters: Service.Parameters.Create) async throws -> Service.Responses.Create {
        try await requestsService
            .request(
                path: "/v1/services",
                method: .post,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Service.Responses.Create.self, decoder: coderService.decoder)
            .value
    }
    
    func update(id: UUID, parameters: Service.Parameters.Update) async throws -> Service.Responses.Update {
        try await requestsService
            .request(
                path: "/v1/services/\(id)",
                method: .put,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Service.Responses.Update.self, decoder: coderService.decoder)
            .value
    }
}

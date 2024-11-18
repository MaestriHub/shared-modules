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
//        public static let liveValue: IServicesService = {
//            @Dependency(\.toggleService) var toggleService
//            return toggleService.isActive(.serviceMocks) ? ServicesServiceMock() : ServicesService()
//        }()
    }
}

// MARK: - Live

struct ServicesService: IServicesService {

    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.coderService) var coderService
    
    // MARK: - Methods
    
    func services(parameters: Service.Parameters.Retrieve) async throws -> [Service.Responses.Partial] {
        try await requestsService
            .request(
                path: "/v1/services",
                method: .get,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable([Service.Responses.Partial].self, decoder: coderService.decoder)
            .value
    }
    
    func create(parameters: Service.Parameters.Create) async throws -> Service.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/services",
                method: .post,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Service.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    func service(id: UUID, parameters: Service.Parameters.RetrieveFull) async throws -> Service.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/services/\(id)",
                method: .get,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Service.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    func update(id: UUID, parameters: Service.Parameters.Patch) async throws -> Service.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/services/\(id)",
                method: .put,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Service.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    func delete(id: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/services/\(id)",
                method: .delete,
                requestType: .other
            )
            .serializingDecodable(Empty.self)
            .value
    }
}

// MARK: - Mock

struct ServicesServiceMock: IServicesService {
    private func createServicesFullMock(prefix: String) -> Service.Responses.Full {
        Service.Responses.Full(
            id: UUID(),
            title: "Service \(prefix)",
            description: "Service \(prefix) description",
            category: .cosmetology,
            procedures: []
        )
    }
    
    private func createServicesFullMocks(count: Int) -> [Service.Responses.Full] {
        (0..<count).map { createServicesFullMock(prefix: "\($0)")}
    }
    
    private func createServicesPartialMock(prefix: String) -> Service.Responses.Partial {
        Service.Responses.Partial(
            id: UUID(),
            title: "Service \(prefix)",
            description: "Service \(prefix) description",
            category: .depilation,
            minPrice: Price(amount: 100, currency: "40"),
            minDuration: 45
        )
    }
    
    func createServicesPartialMocks(count: Int) -> [Service.Responses.Partial] {
        (0..<count).map { createServicesPartialMock(prefix: "\($0)")}
    }
    
    func services(parameters: Service.Parameters.Retrieve) async throws -> [Service.Responses.Partial] {
        createServicesPartialMocks(count: 40)
    }
    
    func create(parameters: Service.Parameters.Create) async throws -> Service.Responses.Full {
        createServicesFullMock(prefix: "create")
    }
    
    func service(id: UUID, parameters: Service.Parameters.RetrieveFull) async throws -> Service.Responses.Full {
        createServicesFullMock(prefix: "procedure")
    }
    
    func update(id: UUID, parameters: Service.Parameters.Patch) async throws -> Service.Responses.Full {
        createServicesFullMock(prefix: "update")
    }
    
    func delete(id: UUID) async throws {}
}

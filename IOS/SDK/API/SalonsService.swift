import Foundation
import Alamofire
import Dependencies
import DTOs

// MARK: - Protocol

public protocol ISalonsService {
    
    /// GET /salons/workshops
    /// В которых он либо работает либо владельцем которых является
    func workshops() async throws -> [Salon.Responses.Partial]
    
    /// Get /salons/:id
    func salon(id: UUID) async throws -> Salon.Responses.Full
    
    /// Post /salons
    func create(parameters: Salon.Parameters.Create) async throws -> Salon.Responses.Full
    
    /// Put /salons
    func update(id: UUID, parameters: Salon.Parameters.Patch) async throws -> Salon.Responses.Full
    
    /// Activate /salons
    func activate(id: UUID) async throws -> Salon.Responses.Full
    
    /// Deactivate /salons
    func deactivate(id: UUID) async throws -> Salon.Responses.Full
    
    /// Delete /salons
    func delete(id: UUID) async throws
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var salonsService: any ISalonsService {
        get { self[SalonsServiceKey.self] }
        set { self[SalonsServiceKey.self] = newValue }
    }
    
    enum SalonsServiceKey: DependencyKey {
        public static var liveValue: ISalonsService = SalonsService()
//        public static let liveValue: ISalonsService = {
//            @Dependency(\.toggleService) var toggleService
//            return toggleService.isActive(.salonMocks) ? SalonsServiceMock() : SalonsService()
//        }()
    }
}

// MARK: - Live

struct SalonsService: ISalonsService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.coderService) var coderService
    
    // MARK: - Methods
    
    func workshops() async throws -> [Salon.Responses.Partial] {
        try await requestsService
            .request(
                path: "/v1/salons/workshops",
                method: .get,
                requestType: .other
            )
            .serializingDecodable([Salon.Responses.Partial].self, decoder: coderService.decoder)
            .value
    }
    
    func create(parameters: Salon.Parameters.Create) async throws -> Salon.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/salons",
                method: .post,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Salon.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    func salon(id: UUID) async throws -> Salon.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/salons/\(id)",
                method: .get,
                requestType: .other
            )
            .serializingDecodable(Salon.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    func update(id: UUID, parameters: Salon.Parameters.Patch) async throws -> Salon.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/salons/\(id)",
                method: .put,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Salon.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    func activate(id: UUID) async throws -> Salon.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/salons/\(id)/activate",
                method: .put,
                requestType: .other
            )
            .serializingDecodable(Salon.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    func deactivate(id: UUID) async throws -> Salon.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/salons/\(id)/deactivate",
                method: .put,
                requestType: .other
            )
            .serializingDecodable(Salon.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    func delete(id: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/salons/\(id)",
                method: .delete,
                requestType: .other
            )
            .serializingDecodable(Empty.self)
            .value
    }
}

final class SalonsServiceMock: ISalonsService {
    
    func workshops() async throws -> [Salon.Responses.Partial] {
        []
    }
    
    func salon(id: UUID) async throws -> Salon.Responses.Full {
        try await Task.sleep(for: .seconds(10))
        return .init(
            id: UUID(),
            name: "Салон №1",
            type: .chain,
            description: nil,
            address: .init(address: "sd", city: "dsf", country: "asd", latitude: 52.123, longitude: 32.123),
            isActive: true,
            canEdit: false,
            isFavorite: false,
            localeId: "_RU",
            timeZoneId: "America/Vancouver"
        )
    }
    
    func create(parameters: Salon.Parameters.Create) async throws -> Salon.Responses.Full {
        .init(
            id: UUID(),
            name: "Салон №1",
            type: .chain,
            description: nil,
            address: .init(
                address: "sd",
                city: "dsf",
                country: "asd",
                latitude: 52.123,
                longitude: 32.123
            ),
            isActive: true,
            canEdit: false,
            isFavorite: false,
            localeId: "_RU",
            timeZoneId: "America/Vancouver"
        )
    }
    
    func update(id: UUID, parameters: Salon.Parameters.Patch) async throws -> Salon.Responses.Full {
        .init(
            id: UUID(),
            name: "Салон №1",
            type: .chain,
            description: nil,
            address: .init(
                address: "sd",
                city: "dsf",
                country: "asd",
                latitude: 52.123,
                longitude: 32.123
            ),
            isActive: true,
            canEdit: false,
            isFavorite: false,
            localeId: "_RU",
            timeZoneId: "America/Vancouver"
        )
    }
    
    func activate(id: UUID) async throws -> Salon.Responses.Full {
        .init(
            id: UUID(),
            name: "Салон №1",
            type: .chain,
            description: nil,
            address: .init(
                address: "sd",
                city: "dsf",
                country: "asd",
                latitude: 52.123,
                longitude: 32.123
            ),
            isActive: true,
            canEdit: false,
            isFavorite: false,
            localeId: "_RU",
            timeZoneId: "America/Vancouver"
        )
    }
    
    func deactivate(id: UUID) async throws -> Salon.Responses.Full {
        .init(
            id: UUID(),
            name: "Салон №1",
            type: .chain,
            description: nil,
            address: .init(
                address: "sd",
                city: "dsf",
                country: "asd",
                latitude: 52.123,
                longitude: 32.123
            ),
            isActive: false,
            canEdit: false,
            isFavorite: false,
            localeId: "_RU",
            timeZoneId: "America/Vancouver"
        )
    }
    
    func delete(id: UUID) async throws {
        try await Task.sleep(for: .seconds(10))
    }
}

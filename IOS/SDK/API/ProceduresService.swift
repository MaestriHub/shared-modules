import Foundation
import Alamofire
import Dependencies
import DTOs
import Combine

// MARK: - Protocol

public protocol IProceduresService {
    
    /// Get /procedures&salonId=123dscsd254423
    /// Передаю id salon для получение процедур по салону
    /// Передаю id master для получение процедур по мастеру
    func procedures(parameters: Procedure.Parameters.Retrieve) async throws -> [Procedure.Responses.Partial]
    
    /// Post /procedures
    /// Создаю процедуру для каждого мастера продолжительность процедуры и сумма своя то есть сущность процедуры описывает процесс,
    /// а вот стоимость и время уже привязано к мастеру и даже возможно в дальнейшем к клиенту
    func create(parameters: Procedure.Parameters.Create) async throws -> Procedure.Responses.Full
    
    /// Get /procedures/:id
    func procedure(id: UUID) async throws -> Procedure.Responses.Full
    
    /// Put /procedures/:id
    func update(id: UUID, parameters: Procedure.Parameters.Patch) async throws -> Procedure.Responses.Full
    
    /// Delete /procedures/:id
    func delete(id: UUID) async throws
    
    /// Слушатель для событий внутри сервиса
    var event: PublishedAction<ProceduresServiceActionType> { get }
}

// MARK: - Events

public enum ProceduresServiceActionType {
    case fetch
    case create
    case update
    case delete
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var proceduresService: any IProceduresService {
        get { self[ProceduresServiceKey.self] }
        set { self[ProceduresServiceKey.self] = newValue }
    }
    
    enum ProceduresServiceKey: DependencyKey {
        public static var liveValue: IProceduresService = ProceduresService()
//        public static let liveValue: IProceduresService = {
//            @Dependency(\.toggleService) var toggleService
//            return toggleService.isActive(.procedureMocks) ? ProceduresServiceMock() : ProceduresService()
//        }()
    }
}

// MARK: - Live

struct ProceduresService: IProceduresService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.coderService) var coderService
    
    var event = PublishedAction<ProceduresServiceActionType>()
    
    // MARK: - Methods
    
    func procedures(parameters: Procedure.Parameters.Retrieve) async throws -> [Procedure.Responses.Partial] {
        let result = try await requestsService
            .request(
                path: "/v1/procedures",
                method: .get,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable([Procedure.Responses.Partial].self, decoder: coderService.decoder)
            .value
        event.send(.fetch)
        return result
    }
    
    func create(parameters: Procedure.Parameters.Create) async throws -> Procedure.Responses.Full {
        let result = try await requestsService
            .request(
                path: "/v1/procedures",
                method: .post,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Procedure.Responses.Full.self, decoder: coderService.decoder)
            .value
        event.send(.create)
        return result
    }
    
    func procedure(id: UUID) async throws -> Procedure.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/procedures/\(id)",
                method: .get,
                requestType: .other
            )
            .serializingDecodable(Procedure.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    func update(id: UUID, parameters: Procedure.Parameters.Patch) async throws -> Procedure.Responses.Full {
        let result = try await requestsService
            .request(
                path: "/v1/procedures/\(id)",
                method: .put,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Procedure.Responses.Full.self, decoder: coderService.decoder)
            .value
        event.send(.update)
        return result
    }
    
    func delete(id: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/procedures/\(id)",
                method: .delete,
                requestType: .other
            )
            .serializingDecodable(Empty.self)
            .value
        event.send(.delete)
    }
}

// MARK: - Mock

//public final class ProceduresServiceMock {
//    
//    private func createPartialMock1(amount: Decimal = 228) -> Procedure.Responses.Partial {
//        Procedure.Responses.Partial(
//            id: UUID(),
//            price: Price(amount: amount, currency: "USD"),
//            duration: 225,
//            description: "Mock procedure description",
//            alias: "MockAlias",
//            service: Service.Responses.Micro(id: UUID(), title: "Service 1", description: "Тест Service 1", category: .brows)
//        )
//    }
//    
//    private func createPartialMock2(amount: Decimal = 228) -> Procedure.Responses.Partial {
//        Procedure.Responses.Partial(
//            id: UUID(),
//            price: Price(amount: amount, currency: "USD"),
//            duration: 225,
//            description: "Mock procedure description 2",
//            alias: "MockAlias",
//            service: Service.Responses.Micro(id: UUID(), title: "Service 2", description: "Тест Service 2", category: .massage)
//        )
//    }
//    
//    private func createFullMock() -> Procedure.Responses.Full {
//        Procedure.Responses.Full(
//            id: UUID(),
//            price: Price(amount: 228, currency: "USD"),
//            duration: 3,
//            description: "sdfsdf",
//            alias: "MockAlias",
//            service: Service.Responses.Micro(id: UUID(), title: "Тест Title", description: "Тест Description", category: .hairdressing),
//            master: Employee.Responses.Partial(
//                id: UUID(),
//                user: nil,
//                contacts: [],
//                position: Position.Responses.Partial(id: UUID(), title: "Mock position")
//            )
//        )
//    }
//}
//
// MARK: - IProceduresService
//
//extension ProceduresServiceMock: IProceduresService {
//    public var event: PublishedAction<ProceduresServiceActionType> {
//        return PublishedAction<ProceduresServiceActionType>()
//    }
//    
//    public func procedures(parameters: Procedure.Parameters.Retrieve) async throws -> [Procedure.Responses.Partial] {
//        [
//            createPartialMock1(amount: 15),
//            createPartialMock1(amount: 15),
//            createPartialMock1(amount: 14.02),
//            createPartialMock2(amount: 30),
//            createPartialMock1(amount: 70)
//        ]
//    }
//    
//    public func create(parameters: Procedure.Parameters.Create) async throws -> Procedure.Responses.Full {
//        createFullMock()
//    }
//    
//    public func procedure(id: UUID) async throws -> Procedure.Responses.Full {
//        createFullMock()
//    }
//    
//    public func update(id: UUID, parameters: Procedure.Parameters.Patch) async throws -> Procedure.Responses.Full {
//        createFullMock()
//    }
//    
//    public func delete(id: UUID) async throws {  }
//}

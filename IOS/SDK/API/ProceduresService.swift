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
    func procedures(parameters: Procedure.Parameters.All) async throws -> Procedure.Responses.All
    
    /// Post /procedures
    /// Создаю процедуру для каждого мастера продолжительность процедуры и сумма своя то есть сущность процедуры описывает процесс,
    /// а вот стоимость и время уже привязано к мастеру и даже возможно в дальнейшем к клиенту
    func create(parameters: Procedure.Parameters.Create) async throws -> Procedure.Responses.Create
    
    /// Get /procedures/:id
    func procedure(id: UUID) async throws -> Procedure.Responses.Retrieve
    
    /// Put /procedures/:id
    func update(id: UUID, parameters: Procedure.Parameters.Update) async throws -> Procedure.Responses.Update
    
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
        public static var liveValue: IProceduresService = ProceduresServiceMock()
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
    
    func procedures(parameters: Procedure.Parameters.All) async throws -> Procedure.Responses.All {
        let result = try await requestsService
            .request(
                path: "/v1/procedures",
                method: .get,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Procedure.Responses.All.self, decoder: coderService.decoder)
            .value
        event.send(.fetch)
        return result
    }
    
    func create(parameters: Procedure.Parameters.Create) async throws -> Procedure.Responses.Create {
        let result = try await requestsService
            .request(
                path: "/v1/procedures",
                method: .post,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Procedure.Responses.Create.self, decoder: coderService.decoder)
            .value
        event.send(.create)
        return result
    }
    
    func procedure(id: UUID) async throws -> Procedure.Responses.Retrieve {
        try await requestsService
            .request(
                path: "/v1/procedures/\(id)",
                method: .get,
                requestType: .other
            )
            .serializingDecodable(Procedure.Responses.Retrieve.self, decoder: coderService.decoder)
            .value
    }
    
    func update(id: UUID, parameters: Procedure.Parameters.Update) async throws -> Procedure.Responses.Update {
        let result = try await requestsService
            .request(
                path: "/v1/procedures/\(id)",
                method: .put,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Procedure.Responses.Update.self, decoder: coderService.decoder)
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

public final class ProceduresServiceMock {
    
    private func createProceduresMock(amount: Int = 10) -> [Procedure.Responses.Helpers.Procedure] {
        let services = createServicesMock()
        let masters = createMastersMock(amount: amount)
        
        return (0..<amount).map { index in
            Procedure.Responses.Helpers.Procedure(
                id: UUID(),
                duration: 30 * (index + 1),
                price: Price(amount: Decimal(1000 + index * 500), currency: "USD"),
                alias: "procedure_\(index)",
                description: "Описание процедуры \(index + 1)",
                serviceId: UUID(index),
                masterId: masters[index - 1].id
            )
        }
    }
    
    private func createServicesMock() -> [Procedure.Responses.Helpers.Service] {
        let services = [
            Procedure.Responses.Helpers.Service(
                id: UUID(1),
                tags: [TranslatedServiceTag(key: .brows, translate: "Брови")],
                title: "Сервис 1"
            ),
            Procedure.Responses.Helpers.Service(
                id: UUID(2),
                tags: [TranslatedServiceTag(key: .brows, translate: "Брови")],
                title: "Сервис 2"
            ),
            Procedure.Responses.Helpers.Service(
                id: UUID(3),
                tags: [TranslatedServiceTag(key: .brows, translate: "Брови")],
                title: "Сервис 3"
            ),
            Procedure.Responses.Helpers.Service(
                id: UUID(4),
                tags: [TranslatedServiceTag(key: .brows, translate: "Брови")],
                title: "Сервис 4"
            ),
            Procedure.Responses.Helpers.Service(
                id: UUID(5),
                tags: [TranslatedServiceTag(key: .brows, translate: "Брови")],
                title: "Сервис 5"
            ),
            Procedure.Responses.Helpers.Service(
                id: UUID(6),
                tags: [TranslatedServiceTag(key: .brows, translate: "Брови")],
                title: "Сервис 6"
            ),
            Procedure.Responses.Helpers.Service(
                id: UUID(7),
                tags: [TranslatedServiceTag(key: .brows, translate: "Брови")],
                title: "Сервис 7"
            ),
            Procedure.Responses.Helpers.Service(
                id: UUID(8),
                tags: [TranslatedServiceTag(key: .brows, translate: "Брови")],
                title: "Сервис 8"
            ),
            Procedure.Responses.Helpers.Service(
                id: UUID(9),
                tags: [TranslatedServiceTag(key: .brows, translate: "Брови")],
                title: "Сервис 9"
            ),
            Procedure.Responses.Helpers.Service(
                id: UUID(10),
                tags: [TranslatedServiceTag(key: .brows, translate: "Брови")],
                title: "Сервис 10"
            )
        ]
        return services
    }
    
    private func createMastersMock(amount: Int = 10) -> [Procedure.Responses.Helpers.Masters] {
        return (0..<amount).map { index in
            Procedure.Responses.Helpers.Masters(
                id: UUID(),
                nickname: "Мастер \(index + 1)",
                avatar: "avatar_\(index).jpg"
            )
        }
    }
    
    //    private func createProceduresMock(amount: Decimal = 228) -> [Procedure.Responses.Helpers.Procedure] {
    //        [
    //            Procedure.Responses.Helpers.Procedure(
    //                id: UUID(),
    //                duration: 225,
    //                price: Price(amount: 2134, currency: "USD"),
    //                alias: "MockAlias",
    //                description: "Mock procedure description",
    //                serviceId: UUID(),
    //                masterId: UUID()
    //            ),
    //            Procedure.Responses.Helpers.Procedure(
    //                id: UUID(),
    //                duration: 225,
    //                price: Price(amount: 2134, currency: "USD"),
    //                alias: "MockAlias",
    //                description: "Mock procedure description",
    //                serviceId: UUID(),
    //                masterId: UUID()
    //            ),
    //            Procedure.Responses.Helpers.Procedure(
    //                id: UUID(),
    //                duration: 225,
    //                price: Price(amount: 2134, currency: "USD"),
    //                alias: "MockAlias",
    //                description: "Mock procedure description",
    //                serviceId: UUID(),
    //                masterId: UUID()
    //            )
    //        ]
    //    }
    //
    //    private func createServicesMock(amount: Decimal = 228) -> [Procedure.Responses.Helpers.Service] {
    //        [
    //            Procedure.Responses.Helpers.Service(
    //                id: UUID(),
    //                tags: [TranslatedServiceTag(key: .brows, translate: "")],
    //                title: "Mock service title"
    //            ),
    //            Procedure.Responses.Helpers.Service(
    //                id: UUID(),
    //                tags: [TranslatedServiceTag(key: .brows, translate: "")],
    //                title: "Mock service title"
    //            ),
    //            Procedure.Responses.Helpers.Service(
    //                id: UUID(),
    //                tags: [TranslatedServiceTag(key: .brows, translate: "")],
    //                title: "Mock service title"
    //            )
    //        ]
    //    }
    //
    //    private func createMastersMock(amount: Decimal = 228) -> [Procedure.Responses.Helpers.Masters] {
    //        [
    //            Procedure.Responses.Helpers.Masters(
    //                id: UUID(),
    //                nickname: "Mock nickname",
    //                avatar: "Mock avatar"
    //            ),
    //            Procedure.Responses.Helpers.Masters(
    //                id: UUID(),
    //                nickname: "Mock nickname",
    //                avatar: "Mock avatar"
    //            ),
    //            Procedure.Responses.Helpers.Masters(
    //                id: UUID(),
    //                nickname: "Mock nickname",
    //                avatar: "Mock avatar"
    //            )
    //        ]
    //    }
}

// MARK: - IProceduresService

extension ProceduresServiceMock: IProceduresService {
    public var event: PublishedAction<ProceduresServiceActionType> {
        return PublishedAction<ProceduresServiceActionType>()
    }
    
    public func procedures(parameters: Procedure.Parameters.All) async throws -> Procedure.Responses.All {
        Procedure.Responses.All(
            procedures: createProceduresMock(),
            services: createServicesMock(),
            masters: createMastersMock()
        )
    }
    
    public func create(parameters: Procedure.Parameters.Create) async throws -> Procedure.Responses.Create {
        Procedure.Responses.Create(
            id: UUID(),
            price: Price(amount: 222, currency: "USD"),
            duration: 225,
            description: "Mock procedure description",
            alias: "MockAlias",
            serviceId: UUID(),
            employeeId: UUID()
        )
    }
    
    public func procedure(id: UUID) async throws -> Procedure.Responses.Retrieve {
        Procedure.Responses.Retrieve(
            id: UUID(),
            price: Price(amount: 2134, currency: "USD"),
            duration: 225,
            description: "Mock procedure description",
            alias: "MockAlias",
            serviceId: UUID(),
            employeeId: UUID()
        )
    }
    
    public func update(id: UUID, parameters: Procedure.Parameters.Update) async throws -> Procedure.Responses.Update {
        Procedure.Responses.Update(
            id: UUID(),
            price: Price(amount: 2134, currency: "USD"),
            duration: 225,
            description: "Mock procedure description",
            alias: "MockAlias",
            serviceId: UUID(),
            employeeId: UUID()
        )
    }
    
    public func delete(id: UUID) async throws { }
}

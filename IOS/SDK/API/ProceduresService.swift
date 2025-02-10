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
        public static var liveValue: IProceduresService = ProceduresService()
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

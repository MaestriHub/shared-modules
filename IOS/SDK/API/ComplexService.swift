//
//  ComplexService.swift
//  shared-modules
//
//  Created by Vitalii Shevtsov on 30.11.2024.
//

import Foundation
import Alamofire
import Dependencies
import DTOs
import Combine

// MARK: - Protocol

public protocol IComplexService {
    
    /// Get /complex&salonId=123dscsd254423
    /// Передаю id salon для получение процедур по салону
    /// Передаю id master для получение процедур по мастеру
    func complexes(parameters: Complex.Parameters.All) async throws -> Complex.Responses.All
    
    /// Post /complex
    /// Создаю процедуру для каждого мастера продолжительность процедуры и сумма своя то есть сущность процедуры описывает процесс,
    /// а вот стоимость и время уже привязано к мастеру и даже возможно в дальнейшем к клиенту
    func create(parameters: Complex.Parameters.Create) async throws -> Complex.Responses.Create
    
    /// Get /complex/:id
    func complex(id: UUID) async throws -> Complex.Responses.Retrieve
    
    /// Put /complex/:id
    func update(id: UUID, parameters: Complex.Parameters.Update) async throws -> Complex.Responses.Update
    
    /// Delete /complex/:id
    func delete(id: UUID) async throws
    
    /// Слушатель для событий внутри сервиса
    var event: PublishedAction<ComplexServiceActionType> { get }
}

// MARK: - Events

public enum ComplexServiceActionType {
    case fetch
    case create
    case update
    case delete
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var complexService: any IComplexService {
        get { self[ComplexServiceKey.self] }
        set { self[ComplexServiceKey.self] = newValue }
    }
    
    enum ComplexServiceKey: DependencyKey {
        public static var liveValue: IComplexService = ComplexService()
    }
}

// MARK: - Live

struct ComplexService: IComplexService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.coderService) var coderService
    
    var event = PublishedAction<ComplexServiceActionType>()
    
    // MARK: - Methods
    
    func complexes(parameters: Complex.Parameters.All) async throws -> Complex.Responses.All {
        let result = try await requestsService
            .request(
                path: "/v1/complex",
                method: .get,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Complex.Responses.All.self, decoder: coderService.decoder)
            .value
        event.send(.fetch)
        return result
    }
    
    func create(parameters: Complex.Parameters.Create) async throws -> Complex.Responses.Create {
        let result = try await requestsService
            .request(
                path: "/v1/complex",
                method: .post,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Complex.Responses.Create.self, decoder: coderService.decoder)
            .value
        event.send(.create)
        return result
    }
    
    func complex(id: UUID) async throws -> Complex.Responses.Retrieve {
        try await requestsService
            .request(
                path: "/v1/complex/\(id)",
                method: .get,
                requestType: .other
            )
            .serializingDecodable(Complex.Responses.Retrieve.self, decoder: coderService.decoder)
            .value
    }
    
    func update(id: UUID, parameters: Complex.Parameters.Update) async throws -> Complex.Responses.Update {
        let result = try await requestsService
            .request(
                path: "/v1/complex/\(id)",
                method: .put,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Complex.Responses.Update.self, decoder: coderService.decoder)
            .value
        event.send(.update)
        return result
    }
    
    func delete(id: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/complex/\(id)",
                method: .delete,
                requestType: .other
            )
            .serializingDecodable(Empty.self)
            .value
        event.send(.delete)
    }
}

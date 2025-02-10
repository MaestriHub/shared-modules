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
    func procedures(parameters: Complex.Parameters.Retrieve) async throws -> [Complex.Responses.Partial]
    
    /// Post /complex
    /// Создаю процедуру для каждого мастера продолжительность процедуры и сумма своя то есть сущность процедуры описывает процесс,
    /// а вот стоимость и время уже привязано к мастеру и даже возможно в дальнейшем к клиенту
    func create(parameters: Complex.Parameters.Create) async throws -> Complex.Responses.Full
    
    /// Get /complex/:id
    func procedure(id: UUID) async throws -> Complex.Responses.Full
    
    /// Put /complex/:id
    func update(id: UUID, parameters: Complex.Parameters.Patch) async throws -> Complex.Responses.Full
    
    /// Delete /complex/:id
    func delete(id: UUID) async throws
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
    
    // MARK: - Methods
    
    func procedures(parameters: Complex.Parameters.Retrieve) async throws -> [Complex.Responses.Partial] {
        try await requestsService
            .request(
                path: "/v1/complex",
                method: .get,
                parameters: parameters
            )
            .serializingValue([Complex.Responses.Partial].self)
    }
    
    func create(parameters: Complex.Parameters.Create) async throws -> Complex.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/complex",
                method: .post,
                parameters: parameters
            )
            .serializingValue(Complex.Responses.Full.self)
    }
    
    func procedure(id: UUID) async throws -> Complex.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/complex/\(id)",
                method: .get
            )
            .serializingValue(Complex.Responses.Full.self)
    }
    
    func update(id: UUID, parameters: Complex.Parameters.Patch) async throws -> Complex.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/complex/\(id)",
                method: .put,
                parameters: parameters
            )
            .serializingValue(Complex.Responses.Full.self)
    }
    
    func delete(id: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/complex/\(id)",
                method: .delete
            )
            .serializingValue(Empty.self)
    }
}

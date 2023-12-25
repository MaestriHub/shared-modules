//
//  ProceduresService.swift
//  Created by Vitaliy Shevtsov on 3/29/23.
//  Copyright © 2023 Maestri Hub. All rights reserved.
//

import Foundation
import Alamofire
import Dependencies
import DTOs

//MARK: - Protocol

public protocol IProceduresService {

    /// Get /procedures&salonId=123dscsd254423
    /// Передаю id salon для получение процедур по салону
    /// Передаю id master для получение процедур по мастеру
    func procedures(parameters: Procedure.Parameters.Retrieve) async throws -> [Procedure.Responses.Partial]
    
    /// Post /procedures
    /// Создаю процедуру для каждого мастера продолжительность процедуры и сумма своя то есть сущность процедуры описывает процесс, а вот стоимость и время уже привязано к мастеру и даже возможно в дальнейшем к клиенту
    func create(parameters: Procedure.Parameters.Create) async throws -> Procedure.Responses.Full
    
    /// Get /procedures/:id
    func procedure(id: UUID) async throws -> Procedure.Responses.Full
    
    /// Put /procedures/:id
    func update(id: UUID, parameters: Procedure.Parameters.Patch) async throws -> Procedure.Responses.Full
    
    /// Delete /procedures/:id
    func delete(id: UUID) async throws
}

//MARK: - DependencyValues

public extension DependencyValues {
    
    var proceduresService: any IProceduresService {
        get { self[ProceduresServiceKey.self] }
        set { self[ProceduresServiceKey.self] = newValue }
    }
    
    enum ProceduresServiceKey: DependencyKey {
        public static let liveValue: IProceduresService = ProceduresService() //ProceduresServiceMock()//
    }
}

//MARK: - Live

public final class ProceduresService: IProceduresService {

    //MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.decoderService) var decoderService
    
    //MARK: - Methods
    
    public func procedures(parameters: Procedure.Parameters.Retrieve) async throws -> [Procedure.Responses.Partial] {
        try await requestsService
            .request(
                path: "/v1/procedures",
                method: .get,
                parameters: parameters
            )
            .serializingDecodable([Procedure.Responses.Partial].self)
            .value
    }
    
    public func create(parameters: Procedure.Parameters.Create) async throws -> Procedure.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/procedures",
                method: .post,
                parameters: parameters
            )
            .serializingDecodable(Procedure.Responses.Full.self)
            .value
    }
    
    public func procedure(id: UUID) async throws -> Procedure.Responses.Full {
        try await requestsService
            .request(path: "/v1/procedures/\(id)", method: .get)
            .serializingDecodable(Procedure.Responses.Full.self)
            .value
    }
    
    public func update(id: UUID, parameters: Procedure.Parameters.Patch) async throws -> Procedure.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/procedures/\(id)",
                method: .put,
                parameters: parameters
            )
            .serializingDecodable(Procedure.Responses.Full.self)
            .value
    }
    
    public func delete(id: UUID) async throws {
        let _ = try await requestsService
            .request(
                path: "/v1/procedures/\(id)",
                method: .delete
            )
            .serializingDecodable(Empty.self)
            .value
    }
    
}

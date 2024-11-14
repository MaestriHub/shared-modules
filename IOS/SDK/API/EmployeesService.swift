//
//  EmployeesService.swift
//  Created by Vitaliy Shevtsov on 3/29/23.
//

import Foundation
import Alamofire
import Dependencies
import DTOs

// MARK: - Protocol

public protocol IEmployeesService {
        
    /// Get /employees/:id
    func employees(parameters: Employee.Parameters.Retrieve) async throws -> [Employee.Responses.Partial]
    
    /// Get /employees/:id
    func employees(id: UUID) async throws -> Employee.Responses.Full
    
    /// Post /employees/invite
    func invite(parameters: Employee.Parameters.Invite) async throws -> Employee.Responses.Full
    
    /// Post /employees/:id/handler
    func handler(id: UUID) async throws -> Employee.Responses.Full
    
    /// Put  /employees/:id
    func update(id: UUID, parameters: Employee.Parameters.Patch) async throws -> Employee.Responses.Full
    
    /// Delete /employees/:id
    func fire(id: UUID) async throws
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var employeesService: any IEmployeesService {
        get { self[EmployeesServiceKey.self] }
        set { self[EmployeesServiceKey.self] = newValue }
    }
    
    enum EmployeesServiceKey: DependencyKey {
        public static let liveValue: IEmployeesService = EmployeesService() //EmployeesServiceMock()
    }
}

// MARK: - Live

struct EmployeesService: IEmployeesService {

    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.coderService) var coderService
    
    // MARK: - Methods
    
    public func employees(parameters: Employee.Parameters.Retrieve) async throws -> [Employee.Responses.Partial] {
        try await requestsService
            .request(
                path: "/v1/employees",
                method: .get,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable([Employee.Responses.Partial].self, decoder: coderService.decoder)
            .value
    }
    
    public func employees(id: UUID) async throws -> Employee.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/employees/\(id)",
                method: .get,
                requestType: .other
            )
            .serializingDecodable(Employee.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    public func invite(parameters: Employee.Parameters.Invite) async throws -> Employee.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/employees/invite",
                method: .post,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Employee.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    public func handler(id: UUID) async throws -> Employee.Responses.Full {
        //TODO: Сюда будет приходить уже целлая ссылка и из неё будем получать id
        try await requestsService
            .request(
                path: "/v1/employees/\(id)/handler",
                method: .put,
                requestType: .other
            )
            .serializingDecodable(Employee.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    public func update(id: UUID, parameters: Employee.Parameters.Patch) async throws -> Employee.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/employees/\(id)",
                method: .put,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Employee.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    public func fire(id: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/employees/\(id)",
                method: .delete,
                requestType: .other
            )
            .serializingDecodable(Empty.self)
            .value
    }
}

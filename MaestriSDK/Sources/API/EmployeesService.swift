//
//  EmployeesService.swift
//  Created by Vitaliy Shevtsov on 3/29/23.
//

import Foundation
import Alamofire
import Dependencies
import DTOs

//MARK: - Protocol

public protocol IEmployeesService {
        
    /// Get /employees/:id
    func employees(parameters: Employee.Parameters.Retrieve) async throws -> [Employee.Responses.Partial]
    
    /// Get /employees/:id
    func employees(id: UUID) async throws -> Employee.Responses.Full
    
    /// Post /employees
    func create(parameters: Employee.Parameters.Invite) async throws -> Vacancy.Responses.Partial
    
    /// Put  /employees/:id
    func update(id: UUID, parameters: Employee.Parameters.Patch) async throws -> Employee.Responses.Full
    
    /// Delete /employees/:id
    func fire(id: UUID) async throws
}

//MARK: - DependencyValues

public extension DependencyValues {
    
    var employeesService: any IEmployeesService {
        get { self[EmployeesServiceKey.self] }
        set { self[EmployeesServiceKey.self] = newValue }
    }
    
    enum EmployeesServiceKey: DependencyKey {
        public static let liveValue: IEmployeesService = EmployeesService() //EmployeesServiceMock()
    }
}

//MARK: - Live

public final class EmployeesService: IEmployeesService {

    //MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.decoderService) var decoderService
    
    //MARK: - Methods
    
    public func employees(parameters: Employee.Parameters.Retrieve) async throws -> [Employee.Responses.Partial] {
        try await requestsService
            .request(
                path: "/v1/employees",
                method: .get,
                parameters: parameters
            )
            .serializingDecodable([Employee.Responses.Partial].self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func employees(id: UUID) async throws -> Employee.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/employees/\(id)",
                method: .get
            )
            .serializingDecodable(Employee.Responses.Full.self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func create(parameters: Employee.Parameters.Invite) async throws -> Vacancy.Responses.Partial {
        try await requestsService
            .request(
                path: "/v1/employees/invite",
                method: .post,
                parameters: parameters
            )
            .serializingDecodable(Vacancy.Responses.Partial.self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func update(id: UUID, parameters: Employee.Parameters.Patch) async throws -> Employee.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/employees/\(id)",
                method: .put,
                parameters: parameters
            )
            .serializingDecodable(Employee.Responses.Full.self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func fire(id: UUID) async throws {
        let _ = try await requestsService
            .request(
                path: "/v1/employees/\(id)",
                method: .delete
            )
            .serializingDecodable(Empty.self)
            .value
    }
}

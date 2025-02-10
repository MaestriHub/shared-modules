import Foundation
import Alamofire
import Dependencies
import DTOs
import Combine

// MARK: - Service protocol

public protocol IAssignmentService {
    
    /// Get  /appointment/employee/history
    func history(parameters: AppointmentEmployee.Parameters.Retrieve) async throws -> [AppointmentEmployee.Responses.Partial]
    
    /// Get /appointment/employee/:id
    /// Возвращает записи сотрудника
    func retrieve(id: UUID) async throws -> AppointmentEmployee.Responses.Full
    
    /// Post /appointment/employee
    func create(parameters: AppointmentEmployee.Parameters.Create) async throws -> AppointmentEmployee.Responses.Full
    
    /// Put /appointment/employee/:id
    /// Обновляет запись если есть разрешния
    @discardableResult
    func update(id: UUID, parameters: AppointmentEmployee.Parameters.Patch) async throws -> AppointmentEmployee.Responses.Full
    
    /// Patch /appointment/employee/approve
    func approve(id: UUID) async throws -> AppointmentEmployee.Responses.Full
    
    /// Patch /appointment/employee/:id/reject
    func reject(id: UUID) async throws -> AppointmentEmployee.Responses.Full
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var assignmentService: any IAssignmentService {
        get { self[AppointmentEmployeeServiceKey.self] }
        set { self[AppointmentEmployeeServiceKey.self] = newValue }
    }
    
    enum AppointmentEmployeeServiceKey: DependencyKey {
        public static var liveValue: IAssignmentService = AssignmentService()
    }
}

// MARK: - Live

struct AssignmentService: IAssignmentService {
    
    // MARK: - Services
    
    @Dependency(\.requestsService) private var requestsService
    
    // MARK: - Methods
    
    func history(parameters: AppointmentEmployee.Parameters.Retrieve) async throws -> [AppointmentEmployee.Responses.Partial] {
        try await requestsService
            .request(
                path: "v1/appointment/employee/history",
                method: .get,
                parameters: parameters
            )
            .serializingValue([AppointmentEmployee.Responses.Partial].self)
    }
    
    func retrieve(id: UUID) async throws -> AppointmentEmployee.Responses.Full {
        try await requestsService
            .request(
                path: "v1/appointment/employee/\(id)",
                method: .get
            )
            .serializingValue(AppointmentEmployee.Responses.Full.self)
    }
    
    func create(parameters: AppointmentEmployee.Parameters.Create) async throws -> AppointmentEmployee.Responses.Full {
        try await requestsService
            .request(
                path: "v1/appointment/employee",
                method: .post,
                parameters: parameters
            )
            .serializingValue(AppointmentEmployee.Responses.Full.self)
    }
    
    func update(id: UUID, parameters: AppointmentEmployee.Parameters.Patch) async throws -> AppointmentEmployee.Responses.Full {
        try await requestsService
            .request(
                path: "v1/appointment/employee/\(id)",
                method: .put,
                parameters: parameters
            )
            .serializingValue(AppointmentEmployee.Responses.Full.self)
    }
    
    func approve(id: UUID) async throws -> AppointmentEmployee.Responses.Full {
        try await requestsService
            .request(
                path: "v1/appointment/employee/\(id)/approve",
                method: .patch
            )
            .serializingValue(AppointmentEmployee.Responses.Full.self)
    }
    
    func reject(id: UUID) async throws -> AppointmentEmployee.Responses.Full {
        try await requestsService
            .request(
                path: "v1/appointment/employee/\(id)/reject",
                method: .patch
            )
            .serializingValue(AppointmentEmployee.Responses.Full.self)
    }
}

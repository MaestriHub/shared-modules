import Foundation
import DTOs
import Dependencies

public protocol IAppointmentService {
    
    /// Get /appointment/customer/current
    func current() async throws -> [AppointmentCustomer.Responses.Full]
    
    /// Get /appointment/customer/history
    func history(parameters: AppointmentCustomer.Parameters.Retrieve) async throws -> [AppointmentCustomer.Responses.Partial]
    
    /// Post /appointment/customer
    func create(parameters: AppointmentCustomer.Parameters.Create, notify: Bool) async throws -> AppointmentCustomer.Responses.Full
    
    /// Put /appointment/customer/:id
    func update(id: UUID, parameters: AppointmentCustomer.Parameters.Patch) async throws -> AppointmentCustomer.Responses.Full
    
    /// Patch /appointment/customer/:id/approve
    func approve(id: UUID) async throws -> AppointmentCustomer.Responses.Full
    
    /// Get /appointment/customer/:id
    func retrieve(id: UUID) async throws -> AppointmentCustomer.Responses.Full
    
    /// Patch /appointment/customer/:id/reject
    func reject(id: UUID) async throws -> AppointmentCustomer.Responses.Full
}

// MARK: - Dependency values

public extension DependencyValues {
    
    var appointmentsService: any IAppointmentService {
        get { self[AppointmentCustomerServiceKey.self] }
        set { self[AppointmentCustomerServiceKey.self] = newValue }
    }
    
    enum AppointmentCustomerServiceKey: DependencyKey {
        public static var liveValue: IAppointmentService = AppointmentService()
    }
}

// MARK: - Live

struct AppointmentService: IAppointmentService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) private var requestsService
    
    // MARK: - Methods
    
    func current() async throws -> [AppointmentCustomer.Responses.Full] {
        try await requestsService
            .request(
                path: "v1/appointment/customer/current",
                method: .get
            )
            .serializingValue([AppointmentCustomer.Responses.Full].self)
    }
    
    func history(parameters: AppointmentCustomer.Parameters.Retrieve) async throws -> [AppointmentCustomer.Responses.Partial] {
        try await requestsService
            .request(
                path: "v1/appointment/customer/history",
                method: .get,
                parameters: parameters
            )
            .serializingValue([AppointmentCustomer.Responses.Partial].self)
    }
    
    func create(parameters: AppointmentCustomer.Parameters.Create, notify: Bool) async throws -> AppointmentCustomer.Responses.Full {
        try await requestsService
            .request(
                path: "v1/appointment/customer",
                method: .post,
                parameters: parameters
            )
            .serializingValue(AppointmentCustomer.Responses.Full.self)
    }
    
    func update(id: UUID, parameters: AppointmentCustomer.Parameters.Patch) async throws -> AppointmentCustomer.Responses.Full {
        try await requestsService
            .request(
                path: "v1/appointment/customer/\(id)",
                method: .put,
                parameters: parameters
            )
            .serializingValue(AppointmentCustomer.Responses.Full.self)
    }
    
    func retrieve(id: UUID) async throws -> AppointmentCustomer.Responses.Full {
        try await requestsService
            .request(
                path: "v1/appointment/customer/\(id)",
                method: .get
            )
            .serializingValue(AppointmentCustomer.Responses.Full.self)
    }
    
    func approve(id: UUID) async throws -> AppointmentCustomer.Responses.Full {
        try await requestsService
            .request(
                path: "v1/appointment/customer/\(id)/approve",
                method: .patch
            )
            .serializingValue(AppointmentCustomer.Responses.Full.self)
    }
    
    func reject(id: UUID) async throws -> AppointmentCustomer.Responses.Full {
        try await requestsService
            .request(
                path: "v1/appointment/customer/\(id)/reject",
                method: .patch
            )
            .serializingValue(AppointmentCustomer.Responses.Full.self)
    }
}

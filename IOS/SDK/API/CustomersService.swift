import Foundation
import Alamofire
import Dependencies
import DTOs

public protocol ICustomersService {
    
    /// GET /customers
    func customers(parameters: Customer.Parameters.Retrieve) async throws -> [Customer.Responses.Partial]
    
    /// GET /customers/:id
    func customer(id: UUID) async throws -> Customer.Responses.Full
    
    /// Create /customers
    func create(parameters: Customer.Parameters.Create) async throws -> Customer.Responses.Partial
    
    /// Invite /customers
    func inviteHandler(id: UUID, parameters: Customer.Parameters.HandleInvite) async throws -> HandleInvite
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var customersService: any ICustomersService {
        get { self[CustomersServiceKey.self] }
        set { self[CustomersServiceKey.self] = newValue }
    }
    
    enum CustomersServiceKey: DependencyKey {
        public static let liveValue: ICustomersService = CustomersService()
    }
}

// MARK: - Live

struct CustomersService: ICustomersService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    
    // MARK: - Methods
    
    func create(parameters: Customer.Parameters.Create) async throws -> Customer.Responses.Partial {
        try await requestsService
            .request(
                path: "v1/customers",
                method: .post,
                parameters: parameters
            )
            .serializingValue(Customer.Responses.Partial.self)
    }
    
    func customers(parameters: Customer.Parameters.Retrieve) async throws -> [Customer.Responses.Partial] {
        try await requestsService
            .request(
                path: "v1/customers",
                method: .get,
                parameters: parameters
            )
            .serializingValue([Customer.Responses.Partial].self)
    }
    
    func customer(id: UUID) async throws -> Customer.Responses.Full {
        try await requestsService
            .request(
                path: "v1/customers/\(id)",
                method: .get
            )
            .serializingValue(Customer.Responses.Full.self)
    }
    
    func inviteHandler(id: UUID, parameters: Customer.Parameters.HandleInvite) async throws -> HandleInvite {
        try await requestsService
            .request(
                path: "v1/customers/\(id)",
                method: .put,
                parameters: parameters
            )
            .serializingValue(HandleInvite.self)
    }
}

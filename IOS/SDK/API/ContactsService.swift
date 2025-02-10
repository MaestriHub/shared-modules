import Foundation
import Alamofire
import Dependencies
import DTOs

public protocol IContactService {
    
    func contacts() async throws -> [Contact.Responses.Full]
    
    func create(customerId: UUID, parameters: Contact.Parameters.Create) async throws -> Contact.Responses.Full
    
    func delete(id: UUID, customerId: UUID) async throws
    
    func create(employeeId: UUID, parameters: Contact.Parameters.Create) async throws -> Contact.Responses.Full
    
    func delete(id: UUID, employeeId: UUID) async throws
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var contactService: any IContactService {
        get { self[ContactServiceKey.self] }
        set { self[ContactServiceKey.self] = newValue }
    }
    
    enum ContactServiceKey: DependencyKey {
        public static let liveValue: IContactService = ContactService()
    }
}

// MARK: - Live

struct ContactService: IContactService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    
    // MARK: - Methods
    
    func contacts() async throws -> [Contact.Responses.Full] {
        try await requestsService
            .request(
                path: "/v1/contacts",
                method: .get
            )
            .serializingValue([Contact.Responses.Full].self)
    }
    
    func create(customerId: UUID, parameters: Contact.Parameters.Create) async throws -> Contact.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/contacts/customer/\(customerId)",
                method: .post,
                parameters: parameters
            )
            .serializingValue(Contact.Responses.Full.self)
    }
    
    func delete(id: UUID, customerId: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/contacts/customer/\(customerId)/\(id)",
                method: .delete
            )
            .serializingValue(Empty.self)
    }
    
    func create(employeeId: UUID, parameters: Contact.Parameters.Create) async throws -> Contact.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/contacts/employee/\(employeeId)",
                method: .post,
                parameters: parameters
            )
            .serializingValue(Contact.Responses.Full.self)
    }
    
    func delete(id: UUID, employeeId: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/contacts/employee/\(employeeId)/\(id)",
                method: .delete
            )
            .serializingValue(Empty.self)
    }
}

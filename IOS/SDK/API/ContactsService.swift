//
//  ContactService.swift
//  Created by Vitaliy Shevtsov on 3/29/23.
//

import Foundation
import Alamofire
import Dependencies
import DTOs

public protocol IContactService {
    
    /// GET /contacts
    /// Возвращает способы связи
    func contacts() async throws -> [Contact.Responses.Full]
    
//    /// Post /contacts/:id/send-code
//    /// Отправка верификационного OTP
//    func sendCode(id: UUID) async throws -> Contact.Responses.Send
//    
//    /// Post  /contacts/:id/verify
//    /// Проверка правильности введённого OTP
//    func verify(id: UUID, parameters: Contact.Parameters.Verify) async throws -> Contact.Responses.Verify
    
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
    @Dependency(\.coderService) var coderService
    
    // MARK: - Methods
    
    public func contacts() async throws -> [Contact.Responses.Full] {
        try await requestsService
            .request(
                path: "/v1/contacts",
                method: .get,
                requestType: .other
            )
            .serializingDecodable([Contact.Responses.Full].self, decoder: coderService.decoder)
            .value
    }
    
    public func create(customerId: UUID, parameters: Contact.Parameters.Create) async throws -> Contact.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/contacts/customer/\(customerId)",
                method: .post,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Contact.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    public func delete(id: UUID, customerId: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/contacts/customer/\(customerId)/\(id)",
                method: .delete,
                requestType: .other
            )
            .serializingDecodable(Empty.self)
            .value
    }
    
    public func create(employeeId: UUID, parameters: Contact.Parameters.Create) async throws -> Contact.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/contacts/employee/\(employeeId)",
                method: .post,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Contact.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    public func delete(id: UUID, employeeId: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/contacts/employee/\(employeeId)/\(id)",
                method: .delete,
                requestType: .other
            )
            .serializingDecodable(Empty.self)
            .value
    }
}

//TODO: Пока не используем
//extension ContactService {
//   
//    public func sendCode(id: UUID) async throws -> Contact.Responses.Send {
//        try await requestsService
//            .request(
//                path: "/v1/contacts/\(id)/send-code",
//                method: .post,
//                requestType: .other
//            )
//            .serializingDecodable(Contact.Responses.Send.self, decoder: coderService.decoder)
//            .value
//    }
//
//    public func verify(id: UUID, parameters: Contact.Parameters.Verify) async throws -> Contact.Responses.Verify {
//        try await requestsService
//            .request(
//                path: "/v1/contacts/\(id)/verify",
//                method: .post,
//                parameters: parameters,
//                requestType: .other
//            )
//            .serializingDecodable(Contact.Responses.Verify.self, decoder: coderService.decoder)
//            .value
//    }
//}

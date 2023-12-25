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
    
    /// Post /contacts
    /// Создаю новую запись
    func create(parameters: Contact.Parameters.Create) async throws -> Contact.Responses.Full
    
    /// Post /contacts/:id/send-code
    /// Отправка верификационного OTP
    func sendCode(id: UUID) async throws -> Contact.Responses.Send
    
    /// Post  /contacts/:id/verify
    /// Проверка правильности введённого OTP
    func verify(id: UUID, parameters: Contact.Parameters.Verify) async throws -> Contact.Responses.Verify
    
    /// Delete /contacts/:id
    /// Удаляет контакт если есть разрешения
    func delete(id: UUID) async throws
}

//MARK: - DependencyValues

public extension DependencyValues {
    
    var contactService: any IContactService {
        get { self[ContactServiceKey.self] }
        set { self[ContactServiceKey.self] = newValue }
    }
    
    enum ContactServiceKey: DependencyKey {
        public static let liveValue: IContactService = ContactService()
    }
}

//MARK: - Live

public final class ContactService: IContactService {
    
    //MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.decoderService) var decoderService
    
    //MARK: - Methods
    
    public func contacts() async throws -> [Contact.Responses.Full] {
        try await requestsService
            .request(path: "/v1/contacts", method: .get)
            .serializingDecodable([Contact.Responses.Full].self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func create(parameters: Contact.Parameters.Create) async throws -> Contact.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/contacts",
                method: .post,
                parameters: parameters
            )
            .serializingDecodable(Contact.Responses.Full.self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func sendCode(id: UUID) async throws -> Contact.Responses.Send {
        try await requestsService
            .request(path: "/v1/contacts/\(id)/send-code", method: .post)
            .serializingDecodable(Contact.Responses.Send.self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func verify(id: UUID, parameters: Contact.Parameters.Verify) async throws -> Contact.Responses.Verify {
        try await requestsService
            .request(
                path: "/v1/contacts/\(id)/verify",
                method: .post,
                parameters: parameters
            )
            .serializingDecodable(Contact.Responses.Verify.self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func delete(id: UUID) async throws {
        let _ = try await requestsService
            .request(
                path: "/v1/contacts/\(id)",
                method: .delete
            )
            .serializingDecodable(Empty.self)
            .value
    }
}

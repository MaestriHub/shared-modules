//
//  NoticesService.swift
//  Created by Vitaliy Shevtsov on 7/17/23.
//  Copyright © 2023 Maestri Hub. All rights reserved.
//

import Foundation
import Alamofire
import Dependencies
import DTOs

// MARK: - Protocol

public protocol INoticesService {
    
    /// Get /notices
    func notices() async throws -> [Notice.Responses.Full]
    
    /// Put /notices/readed/:id
    func readed(id: UUID) async throws
    
    /// Put /notices/readed
    func readedAll() async throws
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var noticesService: any INoticesService {
        get { self[NoticesServiceKey.self] }
        set { self[NoticesServiceKey.self] = newValue }
    }
    
    enum NoticesServiceKey: DependencyKey {
        public static let liveValue: INoticesService = {
            @Dependency(\.toggleService) var toggleService
            return toggleService.isActive(.noticesServiceMocks) ? NoticesServiceMock() : NoticesService()
        }()
    }
}

// MARK: - Live

struct NoticesService: INoticesService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.coderService) var coderService
    
    // MARK: - Methods
    
    public func notices() async throws -> [Notice.Responses.Full] {
        try await requestsService
            .request(
                path: "/v1/notifications",
                method: .get,
                requestType: .other
            )
            .serializingDecodable([Notice.Responses.Full].self, decoder: coderService.decoder)
            .value
    }
    
    public func readed(id: UUID) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/notifications/readed/\(id)",
                method: .put,
                requestType: .other
            )
            .serializingDecodable(Empty.self, emptyResponseCodes: [200])
            .value
    }
    
    public func readedAll() async throws {
        _ = try await requestsService
            .request(
                path: "/v1/notifications/readed",
                method: .put,
                requestType: .other
            )
            .serializingDecodable(Empty.self, emptyResponseCodes: [200])
            .value
    }
}

// MARK: - Mock

public final class NoticesServiceMock {
    static var notices: [Notice.Responses.Full] = [
        Notice.Responses.Full(
            id: UUID(),
            titleKey: "Специальное предложение",
            messageKey: "Купи один - получи второй в подарок!",
            parameters: nil,
            category: .appointmentCustomer,
            isRead: false,
            date: Date.now
        ),
        Notice.Responses.Full(
            id: UUID(),
            titleKey: "Уникальная акция",
            messageKey: "Только сегодня! Покупай больше - плати меньше!",
            parameters: nil,
            category: .appointmentEmployee,
            isRead: false,
            date: Date.now
        ),
        Notice.Responses.Full(
            id: UUID(),
            titleKey: "Эксклюзивное предложение",
            messageKey: "Сделай заказ прямо сейчас и получи скидку на следующую покупку!",
            parameters: nil,
            category: .appointmentCustomer,
            isRead: false,
            date: Date.now
        ),
        Notice.Responses.Full(
            id: UUID(),
            titleKey: "Бонусная программа",
            messageKey: "Приведи друга и получи скидку на свою следующую покупку!",
            parameters: nil,
            category: .appointmentEmployee,
            isRead: false,
            date: Date.now
        ),
        Notice.Responses.Full(
            id: UUID(),
            titleKey: "Специальный дил",
            messageKey: "Только для подписчиков! Получи уникальную скидку при покупке через приложение!",
            parameters: nil,
            category: .appointmentCustomer,
            isRead: false,
            date: Date.now
        )
    ]
}

// MARK: - INoticesService

extension NoticesServiceMock: INoticesService {
    
    public func notices() async throws -> [DTOs.Notice.Responses.Full] {
        NoticesServiceMock.notices
    }
    
    public func readed(id: UUID) async throws {}
    
    public func readedAll() async throws {}
}

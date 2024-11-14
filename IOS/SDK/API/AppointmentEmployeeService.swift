//
//  File.swift
//  MaestriSDK
//
//  Created by aristarh on 24.10.2024.
//

import Foundation
import Alamofire
import Dependencies
import DTOs
import Combine

// MARK: - Service protocol

public protocol IAppointmentEmployeeService {
    
    var appointmentCreatePublisher: PassthroughSubject<AppointmentEmployee.Responses.Full, Never> { get }
    
    /// Get  /appointment/employee/history
    func history(parameters: AppointmentEmployee.Parameters.Retrieve) async throws -> [AppointmentEmployee.Responses.Partial]
    
    /// Get /appointment/employee/:id
    /// Возвращает записи сотрудника
    func retrieve(id: UUID) async throws -> AppointmentEmployee.Responses.Full
    
    /// Post /appointment/employee
    func create(parameters: AppointmentEmployee.Parameters.Create, notify: Bool) async throws -> AppointmentEmployee.Responses.Full
    
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
    
    var appointmentsEmployeeService: any IAppointmentEmployeeService {
        get { self[AppointmentEmployeeServiceKey.self] }
        set { self[AppointmentEmployeeServiceKey.self] = newValue }
    }
    
    enum AppointmentEmployeeServiceKey: DependencyKey {
//        public static var liveValue: IAppointmentEmployeeService = AppointmentEmployeeService()
        public static var liveValue: IAppointmentEmployeeService = {
            @Dependency(\.toggleService) var toggleService
            return toggleService.isActive(.appointmentMocks) ? AppointmentEmployeeServiceMock() : AppointmentEmployeeService()
        }()
    }
}

// MARK: - Live

public struct AppointmentEmployeeService: IAppointmentEmployeeService {
    
    public var appointmentCreatePublisher =  PassthroughSubject<AppointmentEmployee.Responses.Full, Never>()
    
    // MARK: - Services
    
    @Dependency(\.requestsService) private var requestsService
    @Dependency(\.coderService) private var coderService
    
    // MARK: - Methods
    
    public func history(parameters: AppointmentEmployee.Parameters.Retrieve) async throws -> [AppointmentEmployee.Responses.Partial] {
        try await requestsService
            .request(
                path: "v1/appointment/employee/history",
                method: .get,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable([AppointmentEmployee.Responses.Partial].self, decoder: coderService.decoder)
            .value
    }
    
    public func retrieve(id: UUID) async throws -> AppointmentEmployee.Responses.Full {
        try await requestsService
            .request(
                path: "v1/appointment/employee/\(id)",
                method: .get,
                requestType: .other
            )
            .serializingDecodable(AppointmentEmployee.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    public func create(parameters: AppointmentEmployee.Parameters.Create, notify: Bool) async throws -> AppointmentEmployee.Responses.Full {
        let appointment = try await requestsService
            .request(
                path: "v1/appointment/employee/",
                method: .post,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(AppointmentEmployee.Responses.Full.self, decoder: coderService.decoder)
            .value
        if notify {
            appointmentCreatePublisher.send(appointment)
        }
        return appointment
    }
    
    public func update(id: UUID, parameters: AppointmentEmployee.Parameters.Patch) async throws -> AppointmentEmployee.Responses.Full {
        try await requestsService
            .request(
                path: "v1/appointment/employee/\(id)",
                method: .put,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(AppointmentEmployee.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    public func approve(id: UUID) async throws -> AppointmentEmployee.Responses.Full {
        try await requestsService
            .request(
                path: "v1/appointment/employee/\(id)/approve",
                method: .patch,
                requestType: .other
            )
            .serializingDecodable(AppointmentEmployee.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    public func reject(id: UUID) async throws -> AppointmentEmployee.Responses.Full {
        try await requestsService
            .request(
                path: "v1/appointment/employee/\(id)/reject",
                method: .patch,
                requestType: .other
            )
            .serializingDecodable(AppointmentEmployee.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
}

// MARK: - Mock

public final class AppointmentEmployeeServiceMock {

    public var appointmentCreatePublisher = PassthroughSubject<AppointmentEmployee.Responses.Full, Never>()

    // MARK: - Services

    @Dependency(\.date) var date
    @Dependency(\.uuid) var uuidGenerator

    // MARK: - Mock data

    var appointment: AppointmentEmployee.Responses.Full {
        AppointmentEmployee.Responses.Full(
            salon: .init(
                id: uuidGenerator.callAsFunction(),
                name: "salon",
                type: .individual,
                address: .init(
                    address: "Times Square",
                    city: "New York",
                    country: "USA",
                    latitude: 2,
                    longitude: 1
                ),
                isFavorite: true
            ),
            customer: .init(
                id: uuidGenerator.callAsFunction(),
                user: .value(customer: .init(nickname: "Paul Johnson")),
                alias: "Paul",
                contacts: [
                    .init(id: uuidGenerator.callAsFunction(), value: "pauljohnson@gmail.com", isVerify: true, type: .email),
                    .init(id: uuidGenerator.callAsFunction(), value: "+79381615254", isVerify: false, type: .phone)
                ]
            ),
            address: .init(
                address: "Times Square",
                city: "New York",
                country: "USA",
                latitude: 2,
                longitude: 1
            ),
            associative: [
                .init(
                    id: uuidGenerator.callAsFunction(),
                    status: .bothApproved,
                    procedure: .init(
                        id: uuidGenerator.callAsFunction(),
                        price: Price(amount: 120, currency: "USD"),
                        duration: 1,
                        description: "Looooooooong description",
                        alias: "MockAlias",
                        service: .init(
                            id: uuidGenerator.callAsFunction(),
                            title: "MockTitle",
                            description: "Looooooooong description",
                            category: .brows
                        ),
                        master: .init(
                            id: uuidGenerator.callAsFunction(),
                            user: .init(nickname: "MockUserNickname"),
                            contacts: [
                                .init(id: uuidGenerator.callAsFunction(), value: "pauljohnson@gmail.com", isVerify: true, type: .email),
                                .init(id: uuidGenerator.callAsFunction(), value: "+79381615254", isVerify: false, type: .phone)
                            ],
                            position: .init(id: uuidGenerator.callAsFunction(), title: "")
                        )
                    ),
                    time: DateInterval(
                        start: date.now.addingTimeInterval(60*60*2*24),
                        end: date.now.addingTimeInterval(60*60*4*24)
                    ),
                    price: Price(amount: 120, currency: "USD")
                ),
                .init(
                    id: uuidGenerator.callAsFunction(),
                    status: .customerApproved,
                    procedure: .init(
                        id: uuidGenerator.callAsFunction(),
                        price: Price(amount: 120, currency: "USD"),
                        duration: 2,
                        description: "Looooooooong description",
                        alias: "MockAlias",
                        service: .init(
                            id: uuidGenerator.callAsFunction(),
                            title: "MockTitle",
                            description: "Looooooooong description",
                            category: .brows
                        ),
                        master: .init(
                            id: uuidGenerator.callAsFunction(),
                            user: .init(nickname: "MockUserNickname"),
                            contacts: [
                                .init(id: uuidGenerator.callAsFunction(), value: "pauljohnson@gmail.com", isVerify: true, type: .email),
                                .init(id: uuidGenerator.callAsFunction(), value: "+79381615254", isVerify: false, type: .phone)
                            ],
                            position: .init(id: uuidGenerator.callAsFunction(), title: "")
                        )
                    ),
                    time: DateInterval(
                        start: date.now.addingTimeInterval(60*60*2*24),
                        end: date.now.addingTimeInterval(60*60*4*24)
                    ),
                    price: Price(amount: 120, currency: "USD")
                )
            ]
        )
    }

    var appointments: [AppointmentEmployee.Responses.Partial] {
        [
            .init(
                customer: .init(
                    id: uuidGenerator.callAsFunction(),
                    user: .value(customer: .init(nickname: "MockCustomerNickname")),
                    alias: "MockAlias",
                    contacts: [
                        .init(id: uuidGenerator.callAsFunction(), value: "pauljohnson@gmail.com", isVerify: true, type: .email),
                        .init(id: uuidGenerator.callAsFunction(), value: "+79381615254", isVerify: false, type: .phone)
                    ]
                ),
                associative: [
                    .init(
                        id: uuidGenerator.callAsFunction(),
                        status: .bothApproved,
                        procedure: .init(
                            id: uuidGenerator.callAsFunction(),
                            price: Price(amount: 120, currency: "USD"),
                            duration: 2,
                            description: "Looooooooong description",
                            alias: "MockAlias",
                            service: .init(
                                id: uuidGenerator.callAsFunction(),
                                title: "MockTitle",
                                description: "Looooooooong description",
                                category: .brows
                            ),
                            master: .init(
                                id: uuidGenerator.callAsFunction(),
                                user: .init(nickname: "MockUserNickname"),
                                contacts: [
                                    .init(id: uuidGenerator.callAsFunction(), value: "pauljohnson@gmail.com", isVerify: true, type: .email),
                                    .init(id: uuidGenerator.callAsFunction(), value: "+79381615254", isVerify: false, type: .phone)
                                ],
                                position: .init(id: uuidGenerator.callAsFunction(), title: "")
                            )
                        ),
                        time: DateInterval(
                            start: date.now.addingTimeInterval(60*60*2*24),
                            end: date.now.addingTimeInterval(60*60*4*24)
                        ),
                        price: Price(amount: 120, currency: "USD")
                    )
                ]
            ),
            .init(
                customer: .init(
                    id: uuidGenerator.callAsFunction(),
                    user: .value(customer: .init(nickname: "MockCustomerNickname")),
                    alias: "MockAlias",
                    contacts: [
                        .init(id: uuidGenerator.callAsFunction(), value: "pauljohnson@gmail.com", isVerify: true, type: .email),
                        .init(id: uuidGenerator.callAsFunction(), value: "+79381615254", isVerify: false, type: .phone)
                    ]
                ),
                associative: [
                    .init(
                        id: uuidGenerator.callAsFunction(),
                        status: .bothApproved,
                        procedure: .init(
                            id: uuidGenerator.callAsFunction(),
                            price: Price(amount: 120, currency: "USD"),
                            duration: 2,
                            description: "Looooooooong description",
                            alias: "MockAlias",
                            service: .init(
                                id: uuidGenerator.callAsFunction(),
                                title: "MockTitle",
                                description: "Looooooooong description",
                                category: .brows
                            ),
                            master: .init(
                                id: uuidGenerator.callAsFunction(),
                                user: .init(nickname: "MockUserNickname"),
                                contacts: [
                                    .init(id: uuidGenerator.callAsFunction(), value: "pauljohnson@gmail.com", isVerify: true, type: .email),
                                    .init(id: uuidGenerator.callAsFunction(), value: "+79381615254", isVerify: false, type: .phone)
                                ],
                                position: .init(id: uuidGenerator.callAsFunction(), title: "")
                            )
                        ),
                        time: DateInterval(
                            start: date.now.addingTimeInterval(60*60*2*24),
                            end: date.now.addingTimeInterval(60*60*4*24)
                        ),
                        price: Price(amount: 120, currency: "USD")
                    )
                ]
            )
        ]
    }
}

// MARK: - Mock methods

extension AppointmentEmployeeServiceMock: IAppointmentEmployeeService {

    public func update(id: UUID, parameters: AppointmentEmployee.Parameters.Patch) async throws -> AppointmentEmployee.Responses.Full {
        appointment
    }

    public func retrieve(id: UUID) async throws -> AppointmentEmployee.Responses.Full {
        appointment
    }

    public func history(parameters: AppointmentEmployee.Parameters.Retrieve) async throws -> [AppointmentEmployee.Responses.Partial] {
        appointments
    }

    public func reject(id: UUID) async throws -> AppointmentEmployee.Responses.Full {
        appointment
    }

    public func approve(id: UUID) async throws -> AppointmentEmployee.Responses.Full {
        appointment
    }

    public func create(parameters: AppointmentEmployee.Parameters.Create, notify: Bool) async throws -> AppointmentEmployee.Responses.Full {
        appointment
    }
}

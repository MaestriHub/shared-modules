import Foundation
import DTOs
import Dependencies
import Combine

public protocol IAppointmentCustomerService {
    
    var appointmentCreatePublisher: PassthroughSubject<AppointmentCustomer.Responses.Full, Never> { get }
    
    /// Get /appointment/customer/current
    func current() async throws -> [AppointmentCustomer.Responses.Full]
    
    /// Get /appointment/customer/history
    func history(id: UUID, parameters: AppointmentCustomer.Parameters.Retrieve) async throws -> [AppointmentCustomer.Responses.Partial]
    
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
    
    var appointmentsCustomerService: any IAppointmentCustomerService {
        get { self[AppointmentCustomerServiceKey.self] }
        set { self[AppointmentCustomerServiceKey.self] = newValue }
    }
    
    enum AppointmentCustomerServiceKey: DependencyKey {
        public static var liveValue: IAppointmentCustomerService = AppointmentCustomerService()
//        public static let liveValue: IAppointmentCustomerService = {
//            @Dependency(\.toggleService) var toggleService
//            return toggleService.isActive(.appointmentMocks) ? AppointmentCustomerMockService() : AppointmentCustomerService()
//        }()
    }
}

// MARK: - Live

struct AppointmentCustomerService: IAppointmentCustomerService {
    
    var appointmentCreatePublisher = PassthroughSubject<AppointmentCustomer.Responses.Full, Never>()
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) private var requestsService
    @Dependency(\.coderService) private var coderService
    
    // MARK: - Methods
    
    func current() async throws -> [AppointmentCustomer.Responses.Full] {
        try await requestsService
            .request(
                path: "v1/appointment/customer/current",
                method: .get,
                requestType: .other
            )
            .serializingDecodable([AppointmentCustomer.Responses.Full].self, decoder: coderService.decoder)
            .value
    }
    
    func history(id: UUID, parameters: AppointmentCustomer.Parameters.Retrieve) async throws -> [AppointmentCustomer.Responses.Partial] {
        try await requestsService
            .request(
                path: "v1/appointment/customer/history/\(id)",
                method: .get,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable([AppointmentCustomer.Responses.Partial].self, decoder: coderService.decoder)
            .value
    }
    
    func create(parameters: AppointmentCustomer.Parameters.Create, notify: Bool) async throws -> AppointmentCustomer.Responses.Full {
        let response = try await requestsService
            .request(
                path: "v1/appointment/customer",
                method: .post,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(AppointmentCustomer.Responses.Full.self, decoder: coderService.decoder)
            .value
        if notify {
            appointmentCreatePublisher.send(response)
        }
        return response
    }
    
    func update(id: UUID, parameters: AppointmentCustomer.Parameters.Patch) async throws -> AppointmentCustomer.Responses.Full {
        try await requestsService
            .request(
                path: "v1/appointment/customer/\(id)",
                method: .put,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(AppointmentCustomer.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    func retrieve(id: UUID) async throws -> AppointmentCustomer.Responses.Full {
        try await requestsService
            .request(
                path: "v1/appointment/customer/\(id)",
                method: .get,
                requestType: .other
            )
            .serializingDecodable(AppointmentCustomer.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    func approve(id: UUID) async throws -> AppointmentCustomer.Responses.Full {
        try await requestsService
            .request(
                path: "v1/appointment/customer/\(id)/approve",
                method: .patch,
                requestType: .other
            )
            .serializingDecodable(AppointmentCustomer.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
    
    func reject(id: UUID) async throws -> AppointmentCustomer.Responses.Full {
        try await requestsService
            .request(
                path: "v1/appointment/customer/\(id)/reject",
                method: .patch,
                requestType: .other
            )
            .serializingDecodable(AppointmentCustomer.Responses.Full.self, decoder: coderService.decoder)
            .value
    }
}

// MARK: - Mock

final class AppointmentCustomerMockService: IAppointmentCustomerService {
    
    var appointmentCreatePublisher = PassthroughSubject<AppointmentCustomer.Responses.Full, Never>()
    
    // MARK: - Dependencies
    
    @Dependency(\.date) var date
    @Dependency(\.uuid) var uuidGenerator
    
    // MARK: - Mock data
    
    var appointment: AppointmentCustomer.Responses.Full {
        .init(
            id: uuidGenerator.callAsFunction(),
            status: .bothApproved,
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
            procedures: [
                .init(
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
                .init(
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
                )
            ],
            time: DateInterval(
                start: date.now.addingTimeInterval(60*60*2*24),
                end: date.now.addingTimeInterval(60*60*4*24)
            ),
            price: Price(amount: 120, currency: "USD"),
            address: .init(
                address: "Times Square",
                city: "New York",
                country: "USA",
                latitude: 2,
                longitude: 1
            )
        )
    }
    
    var appointments: [AppointmentCustomer.Responses.Partial] {
        [
            .init(
                id: uuidGenerator.callAsFunction(),
                status: .customerDeclined,
                time: DateInterval(
                    start: date.now.addingTimeInterval(60*60*2*24),
                    end: date.now.addingTimeInterval(60*60*4*24)
                ),
                price: Price(amount: 120, currency: "USD"),
                procedures: [
                    .init(
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
                    .init(
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
                    )
                ]
            )
        ]
    }
    
    func approve(id: UUID) async throws -> AppointmentCustomer.Responses.Full {
        appointment
    }
    
    func current() async throws -> [AppointmentCustomer.Responses.Full] {
        [appointment, appointment]
    }
    
    func history(id: UUID, parameters: AppointmentCustomer.Parameters.Retrieve) async throws -> [AppointmentCustomer.Responses.Partial] {
        appointments
    }
    
    func create(parameters: AppointmentCustomer.Parameters.Create, notify: Bool) async throws -> AppointmentCustomer.Responses.Full {
        appointment
    }
    
    func update(id: UUID, parameters: AppointmentCustomer.Parameters.Patch) async throws -> AppointmentCustomer.Responses.Full {
        appointment
    }
    
    func retrieve(id: UUID) async throws -> AppointmentCustomer.Responses.Full {
        appointment
    }
    
    func reject(id: UUID) async throws -> AppointmentCustomer.Responses.Full {
        appointment
    }
}

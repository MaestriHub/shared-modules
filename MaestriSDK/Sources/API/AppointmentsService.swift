//
//  AppointmentsService.swift
//  Created by Vitaliy Shevtsov on 3/29/23.
//

import Foundation
import Alamofire
import Dependencies
import DTOs

public protocol IAppointmentsService {
    
    /// GET /appointments&type=all,salon,master&date=day
    /// Передаю type для получение записей по данному мастеру или салону либо по всем салонам одного владельца
    /// Передаю day что бы получить за конкретный день
    /// Возвращает записи по салону, мастеру, дню
    func appointments(parameters: Appointment.Parameters.Retrieve) async throws -> [Appointment.Responses.Partial]
    
    /// Post /appointments
    /// Создаю новую запись
    func create(parameters: Appointment.Parameters.Create) async throws -> Appointment.Responses.Full
    
    /// Get /appointments/:id
    /// Получение конкрентого appointment
    func appointment(id: UUID) async throws -> Appointment.Responses.Full
    
    /// Put /appointments/:id
    /// Обновляет запись если есть разрешния
    func update(id: UUID, parameters: Appointment.Parameters.Patch) async throws -> Appointment.Responses.Full
    
    /// Patch /appointments/:id/approve
    /// Подтверждает запись если есть разрешния
    func approve(id: UUID) async throws -> Appointment.Responses.Full
    
    /// Patch /appointments/:id/reject
    /// Отменяет запись если есть разрешния
    func reject(id: UUID) async throws -> Appointment.Responses.Full
    
    /// Delete /appointments/:id
    /// Удаляет запись если есть разрешния
    func delete(id: UUID) async throws
}

//MARK: - DependencyValues

public extension DependencyValues {
    
    var appointmentsService: any IAppointmentsService {
        get { self[AppointmentsServiceKey.self] }
        set { self[AppointmentsServiceKey.self] = newValue }
    }
    
    enum AppointmentsServiceKey: DependencyKey {
        public static let liveValue: IAppointmentsService = AppointmentsService()
    }
}

//MARK: - Live

public final class AppointmentsService: IAppointmentsService {
    
    //MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.decoderService) var decoderService
    
    //MARK: - Methods
    
    public func appointments(parameters: Appointment.Parameters.Retrieve) async throws -> [Appointment.Responses.Partial] {
        try await requestsService
            .request(
                path: "/v1/appointments",
                method: .get,
                parameters: parameters
            )
            .serializingDecodable([Appointment.Responses.Partial].self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func create(parameters: Appointment.Parameters.Create) async throws -> Appointment.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/appointments",
                method: .post,
                parameters: parameters
            )
            .serializingDecodable(Appointment.Responses.Full.self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func appointment(id: UUID) async throws -> Appointment.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/appointments/\(id)",
                method: .get
            )
            .serializingDecodable(Appointment.Responses.Full.self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func update(id: UUID, parameters: Appointment.Parameters.Patch) async throws -> Appointment.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/appointments/\(id)",
                method: .put,
                parameters: parameters
            )
            .serializingDecodable(Appointment.Responses.Full.self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func approve(id: UUID) async throws -> Appointment.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/appointments/\(id)/approve",
                method: .patch
            )
            .serializingDecodable(Appointment.Responses.Full.self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func reject(id: UUID) async throws -> Appointment.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/appointments/\(id)/reject",
                method: .patch
            )
            .serializingDecodable(Appointment.Responses.Full.self, decoder: decoderService.jsonDecoder)
            .value
    }
    
    public func delete(id: UUID) async throws {
        let _ = try await requestsService
            .request(
                path: "/v1/appointments/\(id)",
                method: .delete
            )
            .serializingDecodable(Empty.self)
            .value
    }
}

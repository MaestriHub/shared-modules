//
//  TimetablesService.swift
//  Created by Vitaliy Shevtsov on 4/4/23.
//  Copyright © 2023 Maestri Hub. All rights reserved.
//

import Foundation
import Alamofire
import Dependencies
import DTOs

//MARK: - Protocol

public protocol ITimetablesService {
    
    /// Get /timetables/search-slots
    func searchSlots(parameters: Timetable.Parameters.SearchSlot) async throws -> Timetable.Responses.Slot
    
    /// Post /timetables/:id/update
    func update(id: UUID, parameters: Timetable.Parameters.Create) async throws -> Timetable.Responses.Full
    
    /// Post /timetables/:id/add
    func addOfftime(id: UUID, parameters: Timetable.Parameters.Offtime) async throws
    
    /// Delete /timetables/:id/remove
    func removeOfftime(id: UUID) async throws
}

//MARK: - DependencyValues

public extension DependencyValues {
    
    var timetablesService: any ITimetablesService {
        get { self[TimetablesServiceKey.self] }
        set { self[TimetablesServiceKey.self] = newValue }
    }
    
    enum TimetablesServiceKey: DependencyKey {
        public static let liveValue: ITimetablesService = TimetablesService()
    }
}

//MARK: - Live

public final class TimetablesService: ITimetablesService {
    
    //MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.decoderService) var decoderService
    
    //MARK: - Methods
    
    public func searchSlots(parameters: Timetable.Parameters.SearchSlot) async throws -> Timetable.Responses.Slot {
        try await requestsService
            .request(
                path: "/v1/timetables/search-slots",
                method: .get,
                parameters: parameters
            )
            .serializingDecodable(Timetable.Responses.Slot.self)
            .value
    }
    
    public func update(id: UUID, parameters: Timetable.Parameters.Create) async throws -> Timetable.Responses.Full {
        try await requestsService
            .request(
                path: "/v1/timetables/\(id)/update",
                method: .post,
                parameters: parameters
            )
            .serializingDecodable(Timetable.Responses.Full.self)
            .value
    }
    
    public func addOfftime(id: UUID, parameters: Timetable.Parameters.Offtime) async throws {
        let _ = try await requestsService
            .request(
                path: "/v1/timetables/\(id)/add",
                method: .post,
                parameters: parameters
            )
            .serializingDecodable(Empty.self, emptyResponseCodes: [200])
            .value
    }
    
    public func removeOfftime(id: UUID) async throws {
        let _ = try await requestsService
            .request(
                path: "/v1/timetables/\(id)/remove",
                method: .delete
            )
            .serializingDecodable(Empty.self)
            .value
    }
}

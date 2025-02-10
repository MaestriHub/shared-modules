import Foundation
import Alamofire
import Dependencies
import DTOs

// MARK: - Protocol

public protocol ITimetablesService {
    
    /// Get /timetables/search-slots
    func searchSlots(parameters: Timetable.Parameters.SearchSlot) async throws -> Timetable.Responses.Slots
    
    /// Get /timetables/
    func get(parameters: Timetable.Parameters.Retrieve) async throws -> [Timetable.Responses.Schedule]
    
    /// Post /timetables//update
    func update(owner: TimetableOwner, parameters: Timetable.Parameters.Create.Pattern) async throws
}

// MARK: - DependencyValues

public extension DependencyValues {
    
    var timetablesService: any ITimetablesService {
        get { self[TimetablesServiceKey.self] }
        set { self[TimetablesServiceKey.self] = newValue }
    }
    
    enum TimetablesServiceKey: DependencyKey {
        public static var liveValue: ITimetablesService = TimetablesService()
    }
}

// MARK: - Live

struct TimetablesService: ITimetablesService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    
    // MARK: - Methods
    
    func searchSlots(parameters: Timetable.Parameters.SearchSlot) async throws -> Timetable.Responses.Slots {
        try await requestsService
            .request(
                path: "/v1/timetables/search-slots",
                method: .get,
                parameters: parameters
            )
            .serializingValue(Timetable.Responses.Slots.self)
    }
    
    func get(parameters: Timetable.Parameters.Retrieve) async throws -> [Timetable.Responses.Schedule] {
        try await requestsService
            .request(
                path: "/v1/timetables/schedules",
                method: .get,
                parameters: parameters
            )
            .serializingValue([Timetable.Responses.Schedule].self)
    }
    
    func update(owner: TimetableOwner, parameters: Timetable.Parameters.Create.Pattern) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/timetables/\(owner)/\(false)",
                method: .post,
                parameters: parameters
            )
            .serializingValue(Empty.self, emptyResponseCodes: [200])
    }
}

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
//        public static let liveValue: ITimetablesService = {
//            @Dependency(\.toggleService) var toggleService
//            return toggleService.isActive(.timetableMocks) ? TimetablesServiceMock() : TimetablesService()
//        }()
    }
}

// MARK: - Live

struct TimetablesService: ITimetablesService {
    
    // MARK: - Dependencies
    
    @Dependency(\.requestsService) var requestsService
    @Dependency(\.coderService) var coderService
    
    // MARK: - Methods
    
    func searchSlots(parameters: Timetable.Parameters.SearchSlot) async throws -> Timetable.Responses.Slots {
        try await requestsService
            .request(
                path: "/v1/timetables/search-slots",
                method: .get,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Timetable.Responses.Slots.self, decoder: coderService.decoder)
            .value
    }
    
    func get(parameters: Timetable.Parameters.Retrieve) async throws -> [Timetable.Responses.Schedule] {
        try await requestsService
            .request(
                path: "/v1/timetables/schedules",
                method: .get,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable([Timetable.Responses.Schedule].self, decoder: coderService.decoder)
            .value
    }
    
    func update(owner: TimetableOwner, parameters: Timetable.Parameters.Create.Pattern) async throws {
        _ = try await requestsService
            .request(
                path: "/v1/timetables/\(owner)/\(false)",
                method: .post,
                parameters: parameters,
                requestType: .other
            )
            .serializingDecodable(Empty.self, emptyResponseCodes: [200])
            .value
    }
}

//    public func addOfftime(id: UUID, parameters: Timetable.Parameters.CreateOfftime) async throws {
//        let _ = try await requestsService
//            .request(
//                path: "/v1/timetables/\(id)/add",
//                method: .post,
//                parameters: parameters,
//                requestType: .other
//            )
//            .serializingDecodable(Empty.self, emptyResponseCodes: [200])
//            .value
//    }
//
//    public func removeOfftime(id: UUID) async throws {
//        let _ = try await requestsService
//            .request(
//                path: "/v1/timetables/\(id)/remove",
//                method: .delete,
//                requestType: .other
//            )
//            .serializingDecodable(Empty.self)
//            .value
//    }

//// MARK: - TimetablesServiceMock
//
//struct TimetablesServiceMock: ITimetablesService {
//    
//    let salonSchedule: [DateInterval] = [
//        // 28 октября
//        DateInterval(start: DateComponents(calendar: .current, year: 2024, month: 10, day: 28, hour: 10).date!,
//                     end: DateComponents(calendar: .current, year: 2024, month: 10, day: 28, hour: 13).date!),
//        DateInterval(start: DateComponents(calendar: .current, year: 2024, month: 10, day: 28, hour: 14).date!,
//                     end: DateComponents(calendar: .current, year: 2024, month: 10, day: 28, hour: 18).date!),
//        
//        // 29 октября
//        DateInterval(start: DateComponents(calendar: .current, year: 2024, month: 10, day: 29, hour: 10).date!,
//                     end: DateComponents(calendar: .current, year: 2024, month: 10, day: 29, hour: 13).date!),
//        DateInterval(start: DateComponents(calendar: .current, year: 2024, month: 10, day: 29, hour: 14).date!,
//                     end: DateComponents(calendar: .current, year: 2024, month: 10, day: 29, hour: 18).date!),
//
//        // 30 октября
//        DateInterval(start: DateComponents(calendar: .current, year: 2024, month: 10, day: 30, hour: 10).date!,
//                     end: DateComponents(calendar: .current, year: 2024, month: 10, day: 30, hour: 13).date!),
//        DateInterval(start: DateComponents(calendar: .current, year: 2024, month: 10, day: 30, hour: 14).date!,
//                     end: DateComponents(calendar: .current, year: 2024, month: 10, day: 30, hour: 18).date!),
//
//        // 31 октября
//        DateInterval(start: DateComponents(calendar: .current, year: 2024, month: 10, day: 31, hour: 10).date!,
//                     end: DateComponents(calendar: .current, year: 2024, month: 10, day: 31, hour: 13).date!),
//        DateInterval(start: DateComponents(calendar: .current, year: 2024, month: 10, day: 31, hour: 14).date!,
//                     end: DateComponents(calendar: .current, year: 2024, month: 10, day: 31, hour: 18).date!),
//
//        // 1 ноября
//        DateInterval(start: DateComponents(calendar: .current, year: 2024, month: 11, day: 1, hour: 10).date!,
//                     end: DateComponents(calendar: .current, year: 2024, month: 11, day: 1, hour: 13).date!),
//        DateInterval(start: DateComponents(calendar: .current, year: 2024, month: 11, day: 1, hour: 14).date!,
//                     end: DateComponents(calendar: .current, year: 2024, month: 11, day: 1, hour: 18).date!)
//    ]
//
//    func searchSlots(parameters: Timetable.Parameters.SearchSlot) async throws -> Timetable.Responses.Slots {
//        Timetable.Responses.Slots(intervals: salonSchedule, timeZoneId: "Europe/Moscow")
//    }
//    
//    func get(parameters: Timetable.Parameters.Retrieve) async throws -> [Timetable.Responses.Schedule] {
//        
//        // Получаем интервал дат для заданного периода
//        let intervals = try await getDateInterval(parameters: parameters.period)
//        var schedules: [Timetable.Responses.Schedule] = []
//        
//        // Проходим по каждому владельцу в массиве owners
//        for owner in parameters.owners {
//            // Создаём расписание для каждого владельца
//            let schedule = Timetable.Responses.Schedule(
//                owner: owner,
//                intervals: intervals,
//                timeZoneId: "Europe/Moscow"
//            )
//            schedules.append(schedule)
//        }
//        
//        return schedules
//    }
//    
//    func update(owner: TimetableOwner, parameters: Timetable.Parameters.Create.Pattern) async throws {
//        
//    }
//    
//    func getDateInterval(parameters: DateInterval) async throws -> [DateInterval] {
//        var schedule: [DateInterval] = []
//        let calendar = Calendar.current
//        let startHourMorning = 10
//        let endHourMorning = 13
//        let startHourAfternoon = 14
//        let endHourAfternoon = 18
//        
//        // Начальная дата интервала
//        var currentDate = parameters.start
//        
//        // Пока текущая дата находится в пределах интервала
//        while currentDate <= parameters.end {
//            // Проверка на выходной день
//            if !calendar.isDateInWeekend(currentDate) {
//                // Утренний интервал
//                if let startMorning = calendar.date(bySettingHour: startHourMorning, minute: 0, second: 0, of: currentDate),
//                   let endMorning = calendar.date(bySettingHour: endHourMorning, minute: 0, second: 0, of: currentDate) {
//                    schedule.append(DateInterval(start: startMorning, end: endMorning))
//                }
//                
//                // Дневной интервал
//                if let startAfternoon = calendar.date(bySettingHour: startHourAfternoon, minute: 0, second: 0, of: currentDate),
//                   let endAfternoon = calendar.date(bySettingHour: endHourAfternoon, minute: 0, second: 0, of: currentDate) {
//                    schedule.append(DateInterval(start: startAfternoon, end: endAfternoon))
//                }
//            }
//            
//            // Переход к следующему дню
//            guard let nextDay = calendar.date(byAdding: .day, value: 1, to: currentDate) else {
//                throw NSError(domain: "Date Calculation Error", code: 1, userInfo: nil)
//            }
//            
//            currentDate = nextDay
//        }
//        
//        return schedule
//    }
//}

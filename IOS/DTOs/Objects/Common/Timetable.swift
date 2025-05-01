import Foundation
import MemberwiseInit

public enum Timetable {
    public enum Parameters {}
    public enum Responses {}
}

public extension Timetable.Parameters {

    struct Create {
        @MemberwiseInit(.public, _optionalsDefaultNil: true)
        public struct Pattern: Codable, Equatable {
            public var schedule: Schedule.Pattern
            public var startAt: Date
            public var endAt: Date?
        }
        
        @MemberwiseInit(.public, _optionalsDefaultNil: true)
        public struct Flexible: Codable, Equatable {
            public var workDays: Dictionary<Date, Schedule.Day>
        }
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct SearchSlot: Codable {
        public var appointmentType: AppointmentType
        public var customerId: UUID?
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Retrieve: Codable {
        public var owners: [TimetableOwner]
        //Идеально отправлять в salon time zone с 00:00-00:00 что бы были только дни
        public var period: SafeDateInterval
    }
}

public extension Timetable.Responses {
    
    typealias Intervals = [SafeDateInterval]

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Slots: Codable {
        public var intervals: Intervals
        public var timeZoneId: String
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Schedule: Codable, Equatable {
        public var owner: TimetableOwner
        // Для недели 7 дней для месяца 28-31
        public var intervals: Intervals
        public var timeZoneId: String
    }
}

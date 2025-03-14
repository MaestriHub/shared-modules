import Foundation
import MemberwiseInit

public enum Timetable {
    public enum Parameters {}
    public enum Responses {}
}

public extension Timetable.Parameters {

    struct Create {
        @MemberwiseInit(.public)
        public struct Pattern: Parametable, Equatable {
            public var schedule: Schedule.Pattern
            public var startAt: Date
            public var endAt: Date?
        }
        
        @MemberwiseInit(.public)
        public struct Flexible: Parametable, Equatable {
            public var workDays: Dictionary<Date, Schedule.Day>
        }
    }
    
    @MemberwiseInit(.public)
    struct SearchSlot: Parametable {
        public var appointmentType: AppointmentType
        public var customerId: UUID?
    }
    
    @MemberwiseInit(.public)
    struct Retrieve: Parametable {
        public var owners: [TimetableOwner]
        //Идеально отправлять в salon time zone с 00:00-00:00 что бы были только дни
        public var period: SafeDateInterval
    }
}

public extension Timetable.Responses {
    
    typealias Intervals = [SafeDateInterval]

    @MemberwiseInit(.public)
    struct Slots: Responsable {
        public var intervals: Intervals
        public var timeZoneId: String
    }
    
    @MemberwiseInit(.public)
    struct Schedule: Parametable, Responsable, Equatable {
        public var owner: TimetableOwner
        // Для недели 7 дней для месяца 28-31
        public var intervals: Intervals
        public var timeZoneId: String
    }
}

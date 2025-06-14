import Foundation
import MemberwiseInit

public typealias ProcedureId = UUID

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
    
    enum SearchSlot {
        
        @MemberwiseInit(.public, _optionalsDefaultNil: true)
        public struct Procedure: Codable {
            public var id: UUID
        }
        
        @MemberwiseInit(.public, _optionalsDefaultNil: true)
        public struct Complex: Codable {
            public var id: UUID
            public var chunks: [ComplexChunkId : ProcedureId]
        }
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Retrieve: Codable {
        public var owners: [TimetableOwner]
        //Идеально отправлять в salon time zone с 00:00-00:00 что бы были только дни
        public var period: SafeDateInterval
    }
}

public extension Timetable.Responses {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct ProcedureSlots: Codable {
        public var intervals: [SafeDateInterval]
        public var timeZoneId: String
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct ComplexSlots: Codable {
        public var slots: [Slot]
        public var timeZoneId: String
        public var oneSlotSize: SafeDateInterval
        
        @MemberwiseInit(.public)
        public struct Slot: Codable {
            public var chunks: [Chunk]
            
            @MemberwiseInit(.public)
            public struct Chunk: Codable {
                public var id: UUID
                public var procedureId: UUID
                public var time: SafeDateInterval
            }
        }
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Schedule: Codable, Equatable {
        public var owner: TimetableOwner
        // Для недели 7 дней для месяца 28-31
        public var intervals: [SafeDateInterval]
        public var timeZoneId: String
    }
}

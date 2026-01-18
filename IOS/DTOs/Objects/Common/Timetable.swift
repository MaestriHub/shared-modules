import Foundation

public enum Timetable {
    public enum Parameters {}
    public enum Responses {}
}

public extension Timetable.Parameters {

    enum Create {
        public struct Pattern: Codable, Equatable, Sendable {
            public var schedule: Schedule.Pattern
            public var startAt: Date
            public var endAt: Date?
            
            public init(schedule: Schedule.Pattern, startAt: Date, endAt: Date? = nil) {
                self.schedule = schedule
                self.startAt = startAt
                self.endAt = endAt
            }
        }
        
        public struct Flexible: Codable, Equatable, Sendable {
            public var workDays: Dictionary<Date, Schedule.Day>
            
            public init(workDays: Dictionary<Date, Schedule.Day>) {
                self.workDays = workDays
            }
        }
    }
    
    enum SearchSlot {
        public struct Complex: Codable, Sendable {
            public var id: UUID
            public var procedures: [Procedure]
            
            public init(id: UUID, procedures: [Procedure]) {
                self.id = id
                self.procedures = procedures
            }
        }

        public struct Procedure: Codable, Sendable {
            public var id: UUID
            public var executorId: UUID?
            
            public init(id: UUID, executorId: UUID? = nil) {
                self.id = id
                self.executorId = executorId
            }
        }
    }
    
    struct Retrieve: Codable, Sendable {
        public var owners: [TimetableOwner]
        //Идеально отправлять в salon time zone с 00:00-00:00 что бы были только дни
        public var period: SafeDateInterval
        
        public init(owners: [TimetableOwner], period: SafeDateInterval) {
            self.owners = owners
            self.period = period
        }
    }
}

public extension Timetable.Responses {
    
    struct ProcedureSlots: Codable, Sendable {
        public var intervals: [SafeDateInterval]
        public var timeZoneId: String
        
        public init(intervals: [SafeDateInterval], timeZoneId: String) {
            self.intervals = intervals
            self.timeZoneId = timeZoneId
        }
    }
    
    struct ComplexSlots: Codable, Sendable {
        public var slots: [Slot]
        public var timeZoneId: String
        
        public init(slots: [Slot], timeZoneId: String) {
            self.slots = slots
            self.timeZoneId = timeZoneId
        }
        
        public struct Slot: Codable, Sendable {
            public var total: SafeDateInterval
            public var procedures: [Procedure]
            
            public init(total: SafeDateInterval, procedures: [Procedure]) {
                self.total = total
                self.procedures = procedures
            }
            
            public struct Procedure: Codable, Sendable {
                public var id: UUID
                public var executorId: UUID
                public var time: SafeDateInterval
                
                public init(id: UUID, executorId: UUID, time: SafeDateInterval) {
                    self.id = id
                    self.executorId = executorId
                    self.time = time
                }
            }
        }
    }
    
    struct Schedule: Codable, Equatable, Sendable {
        public var owner: TimetableOwner
        // Для недели 7 дней для месяца 28-31
        public var intervals: [SafeDateInterval]
        public var timeZoneId: String
        
        public init(owner: TimetableOwner, intervals: [SafeDateInterval], timeZoneId: String) {
            self.owner = owner
            self.intervals = intervals
            self.timeZoneId = timeZoneId
        }
    }
}

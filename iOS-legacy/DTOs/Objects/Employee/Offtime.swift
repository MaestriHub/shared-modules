import Foundation

public enum Offtime {
    public enum Parameters {}
    public enum Responses {}
}

public extension Offtime.Parameters {
    
    struct Create: Codable, Sendable {
        public var interval: SafeDateInterval
        public var reason: String?
        public var coefficient: Decimal
        
        public init(interval: SafeDateInterval, reason: String? = nil, coefficient: Decimal) {
            self.interval = interval
            self.reason = reason
            self.coefficient = coefficient
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

public extension Offtime.Responses {

    struct Full: Codable, Sendable {
        public var id: UUID
        public var interval: SafeDateInterval
        public var reason: String?
        public var timeZoneId: String
        public var coefficient: Decimal
        
        public init(
            id: UUID,
            interval: SafeDateInterval,
            reason: String? = nil,
            timeZoneId: String,
            coefficient: Decimal
        ) {
            self.id = id
            self.interval = interval
            self.reason = reason
            self.timeZoneId = timeZoneId
            self.coefficient = coefficient
        }
    }
    
    struct Partial: Codable, Sendable {
        public var id: UUID
        public var interval: SafeDateInterval
        
        public init(id: UUID, interval: SafeDateInterval) {
            self.id = id
            self.interval = interval
        }
    }
}

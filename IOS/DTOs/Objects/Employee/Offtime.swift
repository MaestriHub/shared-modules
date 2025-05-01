import Foundation
import MemberwiseInit

public enum Offtime {
    public enum Parameters {}
    public enum Responses {}
}

public extension Offtime.Parameters {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Create: Codable {
        public var interval: SafeDateInterval
        public var reason: String?
        public var coefficient: Decimal
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Retrieve: Codable {
        public var owners: [TimetableOwner]
        //Идеально отправлять в salon time zone с 00:00-00:00 что бы были только дни
        public var period: SafeDateInterval
    }
}

public extension Offtime.Responses {

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Full: Codable {
        public var id: UUID
        public var interval: SafeDateInterval
        public var reason: String?
        public var timeZoneId: String
        public var coefficient: Decimal
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Partial: Codable {
        public var id: UUID
        public var interval: SafeDateInterval
    }
}

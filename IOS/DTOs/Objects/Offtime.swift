import Foundation
import MemberwiseInit

public enum Offtime {
    public enum Parameters {}
    public enum Responses {}
}

public extension Offtime.Parameters {
    
    @MemberwiseInit(.public)
    struct Create: Parametable {
        public var interval: SafeDateInterval
        public var reason: String?
        public var coefficient: Decimal
    }
    
    @MemberwiseInit(.public)
    struct Retrieve: Parametable {
        public var owners: [TimetableOwner]
        //Идеально отправлять в salon time zone с 00:00-00:00 что бы были только дни
        public var period: SafeDateInterval
    }
}

public extension Offtime.Responses {

    @MemberwiseInit(.public)
    struct Full: Responsable {
        public var id: UUID
        public var interval: SafeDateInterval
        public var reason: String?
        public var timeZoneId: String
        public var coefficient: Decimal
    }
    
    @MemberwiseInit(.public)
    struct Partial: Responsable {
        public var id: UUID
        public var interval: SafeDateInterval
    }
}

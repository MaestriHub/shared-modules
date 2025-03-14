import Foundation
import MemberwiseInit

public enum Statistic {
    public enum Parameters {}
    public enum Responses {}
}

public extension Statistic.Parameters {
    
    @MemberwiseInit(.public)
    struct AppointmentsQuery: Parametable {
        public let startDate: Date
        public let endDate: Date
        public let employees: [UUID]?
        public let salons: [UUID]?
    }
}

public extension Statistic.Responses {
    
    @MemberwiseInit(.public)
    struct Appointments: Responsable {
        public var price: Price
        public var count: Int
    }
}

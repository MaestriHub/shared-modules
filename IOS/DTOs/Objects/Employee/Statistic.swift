import Foundation
import MemberwiseInit

public enum Statistic {
    public enum Parameters {}
    public enum Responses {}
}

public extension Statistic.Parameters {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct AppointmentsQuery: Codable {
        public let startDate: Date
        public let endDate: Date
        public let employees: [UUID]?
        public let salons: [UUID]?
    }
}

public extension Statistic.Responses {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Appointments: Codable {
        public var price: Price
        public var count: Int
    }
}

import Foundation

public enum Statistic {
    public enum Parameters {}
    public enum Responses {}
}

public extension Statistic.Parameters {
    
    struct AppointmentsQuery: Codable, Sendable {
        public let startDate: Date
        public let endDate: Date
        public let employees: [UUID]?
        public let salons: [UUID]?
        
        public init(startDate: Date, endDate: Date, employees: [UUID]? = nil, salons: [UUID]? = nil) {
            self.startDate = startDate
            self.endDate = endDate
            self.employees = employees
            self.salons = salons
        }
    }
}

public extension Statistic.Responses {
    
    struct Appointments: Codable, Sendable {
        public var price: Price
        public var count: Int
        
        public init(price: Price, count: Int) {
            self.price = price
            self.count = count
        }
    }
}

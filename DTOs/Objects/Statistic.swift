import Foundation

/// Namespace для всех DTOs относящихся к Statistic
public enum Statistic {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Statistic.Parameters {
    
    /// Query Parameters который передаются для фильтрации  Appointment
    struct AppointmentsQuery: Parametable {
        public var startDate: Date
        public var endDate: Date
        public var employees: [UUID]?
        public var salons: [UUID]?
    }
}

//MARK: - Responses -

public extension Statistic.Responses {
    
    struct Appointments: Responsable {
        var price: Price
        var count: Int
    }
}

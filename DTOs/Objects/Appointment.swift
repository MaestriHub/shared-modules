import Foundation

/// Namespace для всех DTOs относящихся к Appointment
public enum Appointment {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Appointment.Parameters {
    
    /// Query Parameters который передаются для фильтрации  Appointment
    struct Retrieve: Parametable {
        public var startDate: Date
        public var endDate: Date
        public var employees: [UUID]?
        public var salons: [UUID]?
    }
    
    /// Body Parameters который передаются для создания Appointment
    struct Create: Parametable {
        public var salon: UUID
        public var master: UUID
        public var customer: UUID//or Customer.Parameters
        public var procedures: [UUID]
        public var time: Interval
        public var price: Price
        public var address: UUID//or Address.Parameters.Create
    }

    struct Patch: Parametable {
        var time: Interval?
        var price: Price?
        var procedures: [UUID]?
    }
}

//MARK: - Responses -

public extension Appointment.Responses {
    
    struct Full: Responsable {
        
        public var id: UUID
        public var salon: Salon.Responses.Full
        public var customer: Customer.Responses.Partial
        public var master: Employee.Responses.Partial
        public var procedures: [ProcedureResponse]
        public var time: Interval
        public var price: Price
        public var address: Address.Responses.Full
    }
    
    struct Partial: Responsable {
        
        public var id: UUID
        public var customer: Customer.Responses.Partial
        public var master: Employee.Responses.Partial
    }
}

import Foundation

/// Namespace для всех DTOs относящихся к Appointment
public enum Appointment {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Appointment.Parameters {
    
    struct Create: Codable {

        var time: DateInterval
//        var price: Price
//        var address: Address
        
        var customer: CustomerBody
        var master: MasterBody
        var procedures: [ProcedureBody]
    }

    struct Update: Codable {
        
        var time: DateInterval?
//        var price: Price?
        var procedures: [ProcedureBody]?
    }
}

//MARK: - Responses -

public extension Appointment.Responses {
    
    struct Full: Codable {
        
        var id: UUID?
//        var time: IntervalDate
//        var price: Price
//        var address: Address

        var customer: User.Responses.Partial
        var master: User.Responses.Partial
        var procedures: [ProcedureResponse]
    }
    
    struct Partial: Codable {
        public var id: UUID?
        public var customer: User.Responses.Partial
        public var master: User.Responses.Partial
    }
}

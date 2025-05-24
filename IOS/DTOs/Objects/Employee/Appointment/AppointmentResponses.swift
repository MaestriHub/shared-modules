import Foundation
import MemberwiseInit

public struct Appointment_NewResponses {
    public struct All: Codable {
        let complexes : [ComplexAppointment]
        let procedures: [ProcedureAppointment]
    }
}

extension Appointment_NewResponses.All {
    @MemberwiseInit(.public)
    public struct ProcedureAppointment: Codable {
        public var id: UUID
        public var title: String
        public var amount: Decimal
        public var time: SafeDateInterval
        public var summary: AppointmentSummary
        public var procedureId: UUID
    }
    
    @MemberwiseInit(.public)
    public struct ComplexAppointment: Codable {
        public var id: UUID
        public var title: String
        public var price: Decimal
        public var summary: AppointmentSummary
        public var procedures: [Procedure]
        
        @MemberwiseInit(.public)
        public struct Procedure: Codable {
            public var id: UUID
            public var title: String
            public var time: SafeDateInterval
            public var procedureId: UUID
        }
    }
    
    @MemberwiseInit(.public)
    public struct AppointmentSummary: Codable {
        public var clientId: UUID
        public var salonId: UUID
        public var currency: String
    }
}

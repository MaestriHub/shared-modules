import Foundation
import MemberwiseInit

public struct Appointment_NewResponses {
    @MemberwiseInit(.public)
    public struct All: Codable {
        public let complexes : [ComplexAppointment]
        public let procedures: [ProcedureAppointment]
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
        }
    }
    
    @MemberwiseInit(.public)
    public struct AppointmentSummary: Codable {
        public var clientId: UUID
        public var salonId: UUID
        public var currency: String
    }
}

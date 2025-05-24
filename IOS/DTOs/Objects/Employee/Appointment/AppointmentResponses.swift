import Foundation
import MemberwiseInit

public struct Appointment_NewResponses {
    public struct All {
        let complexes : [ComplexAppointment]
        let procedures: [ProcedureAppointment]
    }
    
    @MemberwiseInit(.public)
    public struct ProcedureAppointment {
        public var id: UUID
        public var title: String
        public var amount: Decimal
        public var time: SafeDateInterval
        public var summary: AppointmentSummary
        public var procedureId: UUID
    }
    
    @MemberwiseInit(.public)
    public struct ComplexAppointment {
        public var id: UUID
        public var title: String
        public var price: Decimal
        public var summary: AppointmentSummary
        public var procedures: [Procedure]
        
        @MemberwiseInit(.public)
        public struct Procedure {
            public var id: UUID
            public var title: String
            public var time: SafeDateInterval
            public var procedureId: UUID
        }
    }
    
    @MemberwiseInit(.public)
    public struct AppointmentSummary {
        public var clientId: UUID
        public var salonId: UUID
        public var currency: String
    }
}

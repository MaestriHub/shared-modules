import Foundation
import MemberwiseInit

public struct Appointment_NewResponses {
    @MemberwiseInit(.public)
    public struct All: Codable {
        public let complexes : [ComplexAppointment]
        public let procedures: [ProcedureAppointment]
    }
}

extension Appointment_NewResponses {
    @MemberwiseInit(.public)
    public struct ProcedureAppointment: Codable {
        public var id: UUID
        public var title: String
        public var price: Decimal
        public var clientId: UUID
        public var clientName: String
        public var currency: String
        public var time: SafeDateInterval
        public var procedureId: UUID
        public var employeeId: UUID
    }
    
    @MemberwiseInit(.public)
    public struct ComplexAppointment: Codable {
        public var id: UUID
        public var alias: String?
        public var price: Decimal
        public var clientId: UUID
        public var clientName: String
        public var currency: String
        public var procedures: [Procedure]
        
        @MemberwiseInit(.public)
        public struct Procedure: Codable {
            public var id: UUID
            public var title: String
            public var employeeId: UUID
            public var time: SafeDateInterval
        }
    }
}

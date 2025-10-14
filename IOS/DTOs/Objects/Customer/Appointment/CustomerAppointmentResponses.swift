import Foundation
import MemberwiseInit

public extension CustomerAPI.Appointment.Responses {
    @MemberwiseInit(.public)
    struct All: Codable, Sendable {
        public let complexes : [Complex]
        public let procedures: [Procedure]
    }
}

public extension CustomerAPI.Appointment.Responses {
    @MemberwiseInit(.public)
    struct Procedure: Codable, Sendable {
        public var id: UUID
        public var title: String
        public var price: Decimal
        public var currency: String
        public var time: SafeDateInterval
        public var procedureId: UUID
        public var salonLogo: URL
        public var salonId: UUID
        public var point: CoordinatePoint
        public var address: Address
        public var employeeId: UUID
        public var employeeName: String
        public var employeeAvatar: URL
        public var employeeContacts: [Contact.Shared.PrimaryContact]
    }
    
    @MemberwiseInit(.public)
    struct Complex: Codable, Sendable {
        public var id: UUID
        public var alias: String?
        public var price: Decimal
        public var currency: String
        public var salonLogo: URL
        public var salonId: UUID
        public var point: CoordinatePoint
        public var address: Address
        public var procedures: [Procedure]
        
        @MemberwiseInit(.public)
        public struct Procedure: Codable, Sendable {
            public var id: UUID
            public var title: String
            public var employeeId: UUID
            public var employeeName: String
            public var employeeAvatar: URL
            public var employeeContacts: [Contact.Shared.PrimaryContact]
            public var time: SafeDateInterval
        }
    }
}

import Foundation

public extension CustomerAPI.Appointment.Responses {
    struct All: Codable, Sendable {
        public let complexes : [Complex]
        public let procedures: [Procedure]
        
        public init(complexes: [Complex], procedures: [Procedure]) {
            self.complexes = complexes
            self.procedures = procedures
        }
    }
}

public extension CustomerAPI.Appointment.Responses {
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
        
        public init(
            id: UUID,
            title: String,
            price: Decimal,
            currency: String,
            time: SafeDateInterval,
            procedureId: UUID,
            salonLogo: URL,
            salonId: UUID,
            point: CoordinatePoint,
            address: Address,
            employeeId: UUID,
            employeeName: String,
            employeeAvatar: URL,
            employeeContacts: [Contact.Shared.PrimaryContact]
        ) {
            self.id = id
            self.title = title
            self.price = price
            self.currency = currency
            self.time = time
            self.procedureId = procedureId
            self.salonLogo = salonLogo
            self.salonId = salonId
            self.point = point
            self.address = address
            self.employeeId = employeeId
            self.employeeName = employeeName
            self.employeeAvatar = employeeAvatar
            self.employeeContacts = employeeContacts
        }
    }
    
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
        
        public init(
            id: UUID,
            alias: String?,
            price: Decimal,
            currency: String,
            salonLogo: URL,
            salonId: UUID,
            point: CoordinatePoint,
            address: Address,
            procedures: [Procedure]
        ) {
            self.id = id
            self.alias = alias
            self.price = price
            self.currency = currency
            self.salonLogo = salonLogo
            self.salonId = salonId
            self.point = point
            self.address = address
            self.procedures = procedures
        }
        
        public struct Procedure: Codable, Sendable {
            public var id: UUID
            public var title: String
            public var employeeId: UUID
            public var employeeName: String
            public var employeeAvatar: URL
            public var employeeContacts: [Contact.Shared.PrimaryContact]
            public var time: SafeDateInterval
            
            public init(
                id: UUID,
                title: String,
                employeeId: UUID,
                employeeName: String,
                employeeAvatar: URL,
                employeeContacts: [Contact.Shared.PrimaryContact],
                time: SafeDateInterval
            ) {
                self.id = id
                self.title = title
                self.employeeId = employeeId
                self.employeeName = employeeName
                self.employeeAvatar = employeeAvatar
                self.employeeContacts = employeeContacts
                self.time = time
            }
        }
    }
}

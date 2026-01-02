import Foundation

public enum CustomerAppointment {
    public enum Parameters {}
    public enum Responses {}
    public enum Helpers {}
}

// MARK: - Parameters

public extension CustomerAppointment.Parameters {
    struct All: Codable, Sendable {
        public let startDate: Date?
        public let reversed: Bool?
        public let page: Int
        public let per: Int
        public let salonId: UUID?
        
        public init(startDate: Date?, reversed: Bool?, page: Int, per: Int, salonId: UUID?) {
            self.startDate = startDate
            self.reversed = reversed
            self.page = page
            self.per = per
            self.salonId = salonId
        }
    }
}

// MARK: - Responses

public extension CustomerAppointment.Responses {
    typealias List = [Appointment]
    
    struct Appointment: Codable, Sendable {
        public let id: UUID
        public let bookingId: UUID
        public let status: AppointmentStatus
        public let title: String
        public let description: String?
        public let startTime: Date
        public let endTime: Date
        public let finalPrice: Decimal
        public let discountPrice: Decimal?
        public let currency: String
        public let timezoneId: String
        public let salonId: UUID
        public let salonName: String?
        public let salonLogo: URL?
        public let address: DTOs.Address
        public let assignments: [Assignment]
        
        public init(
            id: UUID,
            bookingId: UUID,
            status: AppointmentStatus,
            title: String,
            description: String?,
            startTime: Date,
            endTime: Date,
            finalPrice: Decimal,
            discountPrice: Decimal?,
            currency: String,
            timezoneId: String,
            salonId: UUID,
            salonName: String?,
            salonLogo: URL?,
            address: DTOs.Address,
            assignments: [Assignment]
        ) {
            self.id = id
            self.bookingId = bookingId
            self.status = status
            self.title = title
            self.description = description
            self.startTime = startTime
            self.endTime = endTime
            self.finalPrice = finalPrice
            self.discountPrice = discountPrice
            self.currency = currency
            self.timezoneId = timezoneId
            self.salonId = salonId
            self.salonName = salonName
            self.salonLogo = salonLogo
            self.address = address
            self.assignments = assignments
        }
    }
    
    struct Assignment: Codable, Sendable {
        public let id: UUID
        public let title: String
        public let price: Decimal
        public let discountPrice: Decimal?
        public let startTime: Date
        public let endTime: Date
        public let procedureId: UUID?
        public let employeeId: UUID
        public let employeeName: String?
        public let employeeAvatar: URL?
        
        public init(
            id: UUID,
            title: String,
            price: Decimal,
            discountPrice: Decimal?,
            startTime: Date,
            endTime: Date,
            procedureId: UUID?,
            employeeId: UUID,
            employeeName: String?,
            employeeAvatar: URL?
        ) {
            self.id = id
            self.title = title
            self.price = price
            self.discountPrice = discountPrice
            self.startTime = startTime
            self.endTime = endTime
            self.procedureId = procedureId
            self.employeeId = employeeId
            self.employeeName = employeeName
            self.employeeAvatar = employeeAvatar
        }
    }
}

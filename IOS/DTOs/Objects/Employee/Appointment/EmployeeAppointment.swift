import Foundation

public enum EmployeeAppointment {
    public enum Parameters {}
    public enum Responses {}
    public enum Helpers {}
}

// MARK: - Parameters

public extension EmployeeAppointment.Parameters {
    struct All: Codable, Sendable {
        public let startDate: Date
        public let endDate: Date?
        public let clientId: UUID?
        public let page: Int?
        public let per: Int?
        public let reversed: Bool?
        
        // Init для запроса по датам
        public init(
            dateInterval: DateInterval,
            clientId: UUID? = nil
        ) {
            self.startDate = dateInterval.start
            self.endDate = dateInterval.end
            self.clientId = clientId
            self.page = nil
            self.per = nil
            self.reversed = nil
        }
        
        // Init для пагинации
        public init(
            startDate: Date,
            clientId: UUID? = nil,
            page: Int,
            per: Int,
            reversed: Bool
        ) {
            self.startDate = startDate
            self.endDate = nil
            self.clientId = clientId
            self.page = page
            self.per = per
            self.reversed = reversed
        }
    }
    
    struct Update: Codable, Sendable {
        public let status: AppointmentStatus?
        public let startTime: Date?
        public let endTime: Date?
        
        // Init для обновления статуса
        public init(status: AppointmentStatus) {
            self.status = status
            self.startTime = nil
            self.endTime = nil
        }
        
        // Init для обновления времени
        public init(startTime: Date, endTime: Date) {
            self.status = nil
            self.startTime = startTime
            self.endTime = endTime
        }
    }
}

// MARK: - Responses

public extension EmployeeAppointment.Responses {
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
        public let clientId: UUID
        public let clientName: String?
        public let clientAvatar: URL?
        public let clientContacts: [Contact.Shared.PrimaryContact]
        public let address: Address
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
            clientId: UUID,
            clientName: String?,
            clientAvatar: URL?,
            clientContacts: [Contact.Shared.PrimaryContact],
            address: Address,
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
            self.clientId = clientId
            self.clientName = clientName
            self.clientAvatar = clientAvatar
            self.clientContacts = clientContacts
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
        public let employeeContacts: [Contact.Shared.PrimaryContact]
        
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
            employeeAvatar: URL?,
            employeeContacts: [Contact.Shared.PrimaryContact]
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
            self.employeeContacts = employeeContacts
        }
    }
}

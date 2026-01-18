import Foundation

public enum EmployeeBooking {
    public enum Parameters {}
    public enum Responses {}
    public enum Helpers {}
}

// MARK: - Parameters

public extension EmployeeBooking.Parameters {
    struct Create: Codable, Sendable {
        public let clientId: UUID?
        public let procedureId: UUID?
        public let executionId: UUID?
        public let complexId: UUID?
        public let items: [EmployeeBooking.Helpers.ComplexItem]?
        public let startTime: Date?
        public let endTime: Date?
        public let addressId: UUID?
        public let discountId: UUID?
        
        // Init для Procedure (с clientId)
        public init(
            clientId: UUID,
            procedureId: UUID,
            executionId: UUID?,
            startTime: Date?,
            endTime: Date?,
            addressId: UUID?,
            discountId: UUID?
        ) {
            self.clientId = clientId
            self.procedureId = procedureId
            self.complexId = nil
            self.executionId = executionId
            self.startTime = startTime
            self.endTime = endTime
            self.items = nil
            self.addressId = addressId
            self.discountId = discountId
        }
        
        // Init для Complex (с clientId и items)
        public init(
            clientId: UUID,
            complexId: UUID,
            items: [EmployeeBooking.Helpers.ComplexItem],
            addressId: UUID?,
            discountId: UUID?
        ) {
            self.clientId = clientId
            self.procedureId = nil
            self.complexId = complexId
            self.executionId = nil
            self.startTime = nil
            self.endTime = nil
            self.items = items
            self.addressId = addressId
            self.discountId = discountId
        }
        
    }
    
    struct RequestOpenBooking: Codable, Sendable {
        public let procedureId: UUID?
        public let executionId: UUID?
        public let complexId: UUID?
        public let items: [EmployeeBooking.Helpers.ComplexItem]
        
        public let startTime: Date?
        public let endTime: Date?
        
        public let addressId: UUID?
        public let discountId: UUID?
        
        // Init для Open Procedure
        public init(
            procedureId: UUID,
            executionId: UUID?,
            startTime: Date?,
            endTime: Date?,
            addressId: UUID?,
            discountId: UUID?
        ) {
            self.procedureId = procedureId
            self.complexId = nil
            self.executionId = executionId
            self.startTime = startTime
            self.endTime = endTime
            self.items = nil
            self.addressId = addressId
            self.discountId = discountId
        }
        
        // Init для Open Complex
        public init(
            complexId: UUID,
            items: [EmployeeBooking.Helpers.ComplexItem],
            addressId: UUID?,
            discountId: UUID?
        ) {
            self.procedureId = nil
            self.complexId = complexId
            self.executionId = nil
            self.startTime = nil
            self.endTime = nil
            self.items = items
            self.addressId = addressId
            self.discountId = discountId
        }
    }
    
    struct Update: Codable, Sendable {
        public let startTime: Date?
        public let endTime: Date?
        public let addressId: UUID?
        public let discountId: UUID?
        
        public init(startTime: Date?, endTime: Date?, addressId: UUID?, discountId: UUID?) {
            self.startTime = startTime
            self.endTime = endTime
            self.addressId = addressId
            self.discountId = discountId
        }
    }
    
    struct All: Codable, Sendable {
        public let startDate: Date
        public let endDate: Date?
        public let status: BookingStatus?
        public let clientId: UUID?
        public let page: Int?
        public let per: Int?
        public let reversed: Bool?
        
        // Init для запроса по датам
        public init(
            dateInterval: DateInterval,
            status: BookingStatus? = nil,
            clientId: UUID? = nil
        ) {
            self.startDate = dateInterval.start
            self.endDate = dateInterval.end
            self.status = status
            self.clientId = clientId
            self.page = nil
            self.per = nil
            self.reversed = nil
        }
        
        // Init для пагинации
        public init(
            startDate: Date,
            status: BookingStatus? = nil,
            clientId: UUID? = nil,
            page: Int,
            per: Int,
            reversed: Bool
        ) {
            self.startDate = startDate
            self.endDate = nil
            self.status = status
            self.clientId = clientId
            self.page = page
            self.per = per
            self.reversed = reversed
        }
    }
}

// MARK: - Responses

public extension EmployeeBooking.Responses {
    typealias List = [Booking]
    
    struct Booking: Codable, Sendable {
        public let id: UUID
        public let createdAt: Date
        public let status: BookingStatus
        public let salonId: UUID
        public let salonName: String
        public let salonLogo: URL
        public let clientId: UUID?
        public let clientName: String?
        public let title: String
        public let description: String?
        public let address: Address?
        public let startTime: Date?
        public let endTime: Date?
        public let currency: String
        public let timezoneId: String
        public let finalPrice: Decimal
        public let discountPrice: Decimal?
        public let items: [BookingItem]
        public let updatedAt: Date?
        
        public init(
            id: UUID,
            createdAt: Date,
            status: BookingStatus,
            salonId: UUID,
            salonName: String,
            salonLogo: URL,
            clientId: UUID?,
            clientName: String?,
            title: String,
            description: String?,
            address: Address?,
            startTime: Date?,
            endTime: Date?,
            currency: String,
            timezoneId: String,
            finalPrice: Decimal,
            discountPrice: Decimal?,
            items: [BookingItem],
            updatedAt: Date?
        ) {
            self.id = id
            self.createdAt = createdAt
            self.status = status
            self.salonId = salonId
            self.salonName = salonName
            self.salonLogo = salonLogo
            self.clientId = clientId
            self.clientName = clientName
            self.title = title
            self.description = description
            self.address = address
            self.startTime = startTime
            self.endTime = endTime
            self.currency = currency
            self.timezoneId = timezoneId
            self.finalPrice = finalPrice
            self.discountPrice = discountPrice
            self.items = items
            self.updatedAt = updatedAt
        }
    }
    
    struct BookingItem: Codable, Sendable {
        public let id: UUID
        public let procedureId: UUID
        public let procedureName: String
        public let executor: EmployeeBooking.Helpers.Executor?
        
        public init(
            id: UUID,
            procedureId: UUID,
            procedureName: String,
            executor: Executor?
        ) {
            self.id = id
            self.procedureId = procedureId
            self.procedureName = procedureName
            self.executor = executor
        }
    }
}

// MARK: - Helpers

public extension EmployeeBooking.Helpers {
    struct ComplexItem: Codable, Sendable {
        public let procedureId: UUID
        public let executionId: UUID?
        public let startTime: Date?
        public let endTime: Date?
        
        // Init с временем (для Complex)
        public init(procedureId: UUID, executionId: UUID?, startTime: Date?, endTime: Date?) {
            self.procedureId = procedureId
            self.executionId = executionId
            self.startTime = startTime
            self.endTime = endTime
        }
        
        // Init без времени (для Open)
        public init(procedureId: UUID, executionId: UUID?) {
            self.procedureId = procedureId
            self.executionId = executionId
            self.startTime = nil
            self.endTime = nil
        }
    }
    
    struct Executor: Codable, Sendable {
        public let id: UUID
        public let name: String
        public let avatar: URL

        public init(id: UUID, name: String, avatar: URL) {
            self.id = id
            self.name = name
            self.avatar = avatar
        }
    }
}

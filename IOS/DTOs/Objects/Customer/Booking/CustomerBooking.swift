import Foundation

public enum CustomerBooking {
    public enum Parameters {}
    public enum Responses {}
    public enum Helpers {}
}

// MARK: - Parameters

public extension CustomerBooking.Parameters {
    struct Create: Codable, Sendable {
        public let salonId: UUID

        public let procedureId: UUID?
        public let executionId: UUID?
        public let complexId: UUID?
        public let items: [CustomerBooking.Helpers.ComplexItem]?

        public let startTime: Date?
        public let endTime: Date?
        public let addressId: UUID?
        public let discountId: UUID?
        public let tracking: String?
        
        // Init для Procedure
        public init(
            salonId: UUID,
            procedureId: UUID,
            executionId: UUID?,
            startTime: Date?,
            endTime: Date?,
            addressId: UUID?,
            discountId: UUID?,
            tracking: String? = nil
        ) {
            self.salonId = salonId
            self.procedureId = procedureId
            self.complexId = nil
            self.executionId = executionId
            self.startTime = startTime
            self.endTime = endTime
            self.items = nil
            self.addressId = addressId
            self.discountId = discountId
            self.tracking = tracking
        }
        
        // Init для Complex (с items)
        public init(
            salonId: UUID,
            complexId: UUID,
            items: [CustomerBooking.Helpers.ComplexItem],
            startTime: Date?,
            endTime: Date?,
            addressId: UUID?,
            discountId: UUID?,
            tracking: String? = nil
        ) {
            self.salonId = salonId
            self.procedureId = nil
            self.executionId = nil
            self.complexId = complexId
            self.items = items
            self.startTime = startTime
            self.endTime = endTime
            self.addressId = addressId
            self.discountId = discountId
            self.tracking = tracking
        }
    }
    
    struct Update: Codable, Sendable {
        public let procedureId: UUID?
        public let executionId: UUID?
        public let complexId: UUID?
        public let items: [CustomerBooking.Helpers.ComplexItem]?
        public let startTime: Date?
        public let endTime: Date?
        public let addressId: UUID?
        public let discountId: UUID?
        
        public init(
            procedureId: UUID?,
            executionId: UUID?,
            startTime: Date?,
            endTime: Date?,
            addressId: UUID?,
            discountId: UUID?
        ) {
            self.procedureId = procedureId
            self.executionId = executionId
            self.complexId = nil
            self.items = nil
            self.startTime = startTime
            self.endTime = endTime
            self.addressId = addressId
            self.discountId = discountId
        }

        public init(
            complexId: UUID?,
            items: [CustomerBooking.Helpers.ComplexItem]?,
            startTime: Date?,
            endTime: Date?,
            addressId: UUID?,
            discountId: UUID?
        ) {
            self.procedureId = nil
            self.executionId = nil
            self.complexId = complexId
            self.items = items
            self.startTime = startTime
            self.endTime = endTime
            self.addressId = addressId
            self.discountId = discountId
        }
    }
    
    struct All: Codable, Sendable {
        public let status: BookingStatus?
        public let page: Int
        public let per: Int
        
        public init(status: BookingStatus?, page: Int, per: Int) {
            self.status = status
            self.page = page
            self.per = per
        }
    }
}

// MARK: - Responses

public extension CustomerBooking.Responses {
    typealias List = [Booking]
    
    struct Booking: Codable, Sendable {
        public let id: UUID
        public let createdAt: Date
        public let status: BookingStatus
        public let salonId: UUID
        public let salonName: String
        public let salonLogo: URL
        public let title: String
        public let description: String?
        public let items: [BookingItem]
        public let address: Address?
        public let startTime: Date?
        public let endTime: Date?
        public let timezoneId: String
        public let finalPrice: Decimal
        public let discountPrice: Decimal?
        public let currency: String
        
        public init(
            id: UUID,
            createdAt: Date,
            status: BookingStatus,
            salonId: UUID,
            salonName: String,
            salonLogo: URL,
            title: String,
            description: String?,
            items: [BookingItem],
            address: Address?,
            startTime: Date?,
            endTime: Date?,
            timezoneId: String,
            finalPrice: Decimal,
            discountPrice: Decimal?,
            currency: String
        ) {
            self.id = id
            self.createdAt = createdAt
            self.status = status
            self.salonId = salonId
            self.salonName = salonName
            self.salonLogo = salonLogo
            self.title = title
            self.description = description
            self.items = items
            self.address = address
            self.startTime = startTime
            self.endTime = endTime
            self.timezoneId = timezoneId
            self.finalPrice = finalPrice
            self.discountPrice = discountPrice
            self.currency = currency
        }
    }
    
    struct BookingItem: Codable, Sendable {
        public let id: UUID
        public let procedureId: UUID
        public let procedureName: String
        public let executor: CustomerBooking.Helpers.Executor?
        
        
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

public extension CustomerBooking.Helpers {
    struct ComplexItem: Codable, Sendable {
        public let procedureId: UUID
        public let executionId: UUID?
        public let startTime: Date?
        public let endTime: Date?
        
        public init(procedureId: UUID, executionId: UUID?, startTime: Date?, endTime: Date?) {
            self.procedureId = procedureId
            self.executionId = executionId
            self.startTime = startTime
            self.endTime = endTime
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

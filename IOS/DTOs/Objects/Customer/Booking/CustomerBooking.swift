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
            addressId: UUID?,
            discountId: UUID?,
            tracking: String? = nil
        ) {
            self.salonId = salonId
            self.procedureId = nil
            self.complexId = complexId
            self.executionId = nil
            self.startTime = nil
            self.endTime = nil
            self.items = items
            self.addressId = addressId
            self.discountId = discountId
            self.tracking = tracking
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
        public let status: BookingStatus
        public let salonId: UUID
        public let salonName: String
        public let salonLogo: URL
        public let address: Address?
        public let startTime: Date?
        public let endTime: Date?
        public let currency: String
        public let timezoneId: String
        public let items: [BookingItem]
        public let createdAt: Date
        
        public init(
            id: UUID,
            status: BookingStatus,
            salonId: UUID,
            salonName: String,
            salonLogo: URL,
            address: Address?,
            startTime: Date?,
            endTime: Date?,
            currency: String,
            timezoneId: String,
            items: [BookingItem],
            createdAt: Date
        ) {
            self.id = id
            self.status = status
            self.salonId = salonId
            self.salonName = salonName
            self.salonLogo = salonLogo
            self.address = address
            self.startTime = startTime
            self.endTime = endTime
            self.currency = currency
            self.timezoneId = timezoneId
            self.items = items
            self.createdAt = createdAt
        }
    }
    
    struct BookingItem: Codable, Sendable {
        public let id: UUID
        public let procedureId: UUID
        public let executionId: UUID?
        public let procedureName: String
        
        public init(id: UUID, procedureId: UUID, executionId: UUID?, procedureName: String) {
            self.id = id
            self.procedureId = procedureId
            self.executionId = executionId
            self.procedureName = procedureName
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
}

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
        public let salonId: UUID
        public let procedureId: UUID?
        public let complexId: UUID?
        public let executionId: UUID?
        public let startTime: Date?
        public let endTime: Date?
        public let items: [EmployeeBooking.Helpers.ComplexItem]?
        public let addressId: UUID?
        public let discountId: UUID?
        
        // Init для Procedure (с clientId)
        public init(
            clientId: UUID,
            salonId: UUID,
            procedureId: UUID,
            executionId: UUID?,
            startTime: Date?,
            endTime: Date?,
            addressId: UUID?,
            discountId: UUID?
        ) {
            self.clientId = clientId
            self.salonId = salonId
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
            salonId: UUID,
            complexId: UUID,
            items: [EmployeeBooking.Helpers.ComplexItem],
            addressId: UUID?,
            discountId: UUID?
        ) {
            self.clientId = clientId
            self.salonId = salonId
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
        public let salonId: UUID
        public let procedureId: UUID?
        public let complexId: UUID?
        public let executionId: UUID?
        public let startTime: Date?
        public let endTime: Date?
        public let items: [EmployeeBooking.Helpers.ComplexItem]
        public let addressId: UUID?
        public let discountId: UUID?
        
        // Init для Open Procedure
        public init(
            salonId: UUID,
            procedureId: UUID,
            executionId: UUID?,
            startTime: Date?,
            endTime: Date?,
            items: [EmployeeBooking.Helpers.ComplexItem],
            addressId: UUID?,
            discountId: UUID?
        ) {
            self.salonId = salonId
            self.procedureId = procedureId
            self.complexId = nil
            self.executionId = executionId
            self.startTime = startTime
            self.endTime = endTime
            self.items = items
            self.addressId = addressId
            self.discountId = discountId
        }
        
        // Init для Open Complex
        public init(
            salonId: UUID,
            complexId: UUID,
            items: [EmployeeBooking.Helpers.ComplexItem],
            addressId: UUID?,
            discountId: UUID?
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
        public let clientId: UUID?
        public let page: Int
        public let per: Int
        
        public init(status: BookingStatus?, clientId: UUID?, page: Int, per: Int) {
            self.status = status
            self.clientId = clientId
            self.page = page
            self.per = per
        }
    }
}

// MARK: - Responses

public extension EmployeeBooking.Responses {
    typealias List = [Booking]
    
    struct Booking: Codable, Sendable {
        public let id: UUID
        public let status: BookingStatus
        public let salonId: UUID
        public let salonName: String?
        public let clientId: UUID?
        public let clientName: String?
        public let addressId: UUID?
        public let startTime: Date?
        public let endTime: Date?
        public let currency: String
        public let timezoneId: String
        public let items: [BookingItem]
        public let createdAt: Date?
        public let updatedAt: Date?
        
        public init(
            id: UUID,
            status: BookingStatus,
            salonId: UUID,
            salonName: String?,
            clientId: UUID?,
            clientName: String?,
            addressId: UUID?,
            startTime: Date?,
            endTime: Date?,
            currency: String,
            timezoneId: String,
            items: [BookingItem],
            createdAt: Date?,
            updatedAt: Date?
        ) {
            self.id = id
            self.status = status
            self.salonId = salonId
            self.salonName = salonName
            self.clientId = clientId
            self.clientName = clientName
            self.addressId = addressId
            self.startTime = startTime
            self.endTime = endTime
            self.currency = currency
            self.timezoneId = timezoneId
            self.items = items
            self.createdAt = createdAt
            self.updatedAt = updatedAt
        }
    }
    
    struct BookingItem: Codable, Sendable {
        public let id: UUID
        public let procedureId: UUID
        public let executionId: UUID?
        public let procedureName: String?
        
        public init(id: UUID, procedureId: UUID, executionId: UUID?, procedureName: String?) {
            self.id = id
            self.procedureId = procedureId
            self.executionId = executionId
            self.procedureName = procedureName
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
}

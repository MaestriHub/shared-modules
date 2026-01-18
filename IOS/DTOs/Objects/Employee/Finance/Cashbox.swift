import Foundation

/*
public enum Cashbox {
    public enum Parameters {}
    public enum Responses {}
}

public extension Cashbox.Parameters {
    
    struct Create: Codable, Sendable {
        public var salonId: UUID
        public var paymentType: PaymentType
        
        public init(salonId: UUID, paymentType: PaymentType) {
            self.salonId = salonId
            self.paymentType = paymentType
        }
    }

    struct Retrieve: Codable, Sendable {
        public var paymentType: PaymentType?
        public var startDate: Date?
        public var endDate: Date?
        
        public init(paymentType: PaymentType? = nil, startDate: Date? = nil, endDate: Date? = nil) {
            self.paymentType = paymentType
            self.startDate = startDate
            self.endDate = endDate
        }
    }
}

public extension Cashbox.Responses {

    struct Full: Codable, Identifiable, Hashable, Equatable, Sendable {
        public var id: UUID
        public var createDate: Date
        public var paymentType: PaymentType
        
        public init(id: UUID, createDate: Date, paymentType: PaymentType) {
            self.id = id
            self.createDate = createDate
            self.paymentType = paymentType
        }
    }
}

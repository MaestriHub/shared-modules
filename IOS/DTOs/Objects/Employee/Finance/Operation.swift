import Foundation

public enum Operation {
    public enum Parameters {}
    public enum Responses {}
}

public extension Operation.Parameters {
    struct Create: Codable, Sendable {
        public var price: Price
        public var paymentType: PaymentType
        public var salonId: UUID
        public var appointment: OperationInfo.AppointmentOperation?
        public var salary: OperationInfo.SalaryOperation?
        public var other: OperationInfo.OtherOperation?
        

        public init (
            price: Price,
            paymentType: PaymentType,
            appointment: OperationInfo.AppointmentOperation,
            salonId: UUID
        ) {
            self.price = price
            self.paymentType = paymentType
            self.appointment = appointment
            self.salonId = salonId
        }

        public init (
            price: Price,
            paymentType: PaymentType,
            salary: OperationInfo.SalaryOperation,
            salonId: UUID
        ) {
            self.price = price
            self.paymentType = paymentType
            self.salary = salary
            self.salonId = salonId
        }

        public init (
            price: Price,
            paymentType: PaymentType,
            other: OperationInfo.OtherOperation,
            salonId: UUID
        ) {
            self.price = price
            self.paymentType = paymentType
            self.other = other 
            self.salonId = salonId
        }
    }

    struct Retrieve: Codable, Sendable {
        public var startDate: Date?
        public var endDate: Date?
        public var paymentType: PaymentType?
        public var cashboxIds: [UUID]?
        
        public init(
            startDate: Date? = nil,
            endDate: Date? = nil,
            paymentType: PaymentType? = nil,
            cashboxIds: [UUID]? = nil
        ) {
            self.startDate = startDate
            self.endDate = endDate
            self.paymentType = paymentType
            self.cashboxIds = cashboxIds
        }
    }
}

public extension Operation.Responses {

    struct Full: Codable, Identifiable, Hashable, Equatable, Sendable {
        public var id: UUID
        public var createDate: Date
        public var price: Price
        public var paymentType: PaymentType
        
        public init(id: UUID, createDate: Date, price: Price, paymentType: PaymentType) {
            self.id = id
            self.createDate = createDate
            self.price = price
            self.paymentType = paymentType
        }
    }
}

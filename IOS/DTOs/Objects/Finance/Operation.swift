import Foundation
import MemberwiseInit

public enum Operation {
    public enum Parameters {}
    public enum Responses {}
}

public extension Operation.Parameters {
    struct Create: Parametable {
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

    @MemberwiseInit(.public)
    struct Retrieve: Parametable {
        public var startDate: Date?
        public var endDate: Date?
        public var paymentType: PaymentType?
        public var cashboxIds: [UUID]?
    }
}

public extension Operation.Responses {

    @MemberwiseInit(.public)
    struct Full: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
        public var createDate: Date
        public var price: Price
        public var paymentType: PaymentType
    }
}

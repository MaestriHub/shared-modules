import Foundation

public enum Operation {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Operation.Parameters {
    struct Create: Parametable {
        public var price: Price
        public var paymentType: PaymentType
        public var salonId: UUID
        public var appointment: AppointmentOperation?
        public var salary: SalaryOperation?
        public var other: OtherOperation?
        

        public init (
            price: Price,
            paymentType: PaymentType,
            appointment: AppointmentOperation,
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
            salary: SalaryOperation,
            salonId: UUID
        ) {
            self.price = price
            self.paymentType = paymentType
            self.salary = salary
            self.salonId = salonId
        }

        // вообще лучше не other а дописать для всех, пока просто тестчу
        public init (
            price: Price,
            paymentType: PaymentType,
            other: OtherOperation,
            salonId: UUID
        ) {
            self.price = price
            self.paymentType = paymentType
            self.other = other 
            self.salonId = salonId
        }
    }

    struct Retrieve: Parametable {
        public var startDate: Date?
        public var endDate: Date?
        public var paymentType: PaymentType?
        public var cashboxIds: [UUID]?
        
        public init(
            startDate: Date?,
            endDate: Date?,
            paymentType: PaymentType?,
            cashboxIds: [UUID]?
        ) {
            self.startDate = startDate
            self.endDate = endDate
            self.paymentType = paymentType
            self.cashboxIds = cashboxIds
        }
    }
}


//MARK: - Responses -

public extension Operation.Responses {

    struct Full: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
        public var createDate: Date
        public var price: Price
        public var paymentType: PaymentType

        public init(
            id: UUID,
            createDate: Date,
            price: Price,
            paymentType: PaymentType
        ){
            self.id = id
            self.createDate = createDate
            self.price = price
            self.paymentType = paymentType
        }
    }
}
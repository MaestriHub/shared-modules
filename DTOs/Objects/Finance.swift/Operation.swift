import Foundation

public enum Operation {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Operation.Parameters {
    struct Create: Parametable {
        public var price: Price
        public var operationType: OperationType
        public var paymentType: PaymentType
        public var salonId: UUID

        public init(
            price: Price,
            operationType: OperationType,
            paymentType: PaymentType,
            salonId: UUID
        ){
            self.price = price
            self.operationType = operationType
            self.paymentType = paymentType
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
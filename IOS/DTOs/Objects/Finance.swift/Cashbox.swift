import Foundation

public enum Cashbox {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Cashbox.Parameters {
    struct Create: Parametable {
        public var salonId: UUID
        public var paymentType: PaymentType

        public init(
            salonId: UUID,
            paymentType: PaymentType
        ){
            self.salonId = salonId
            self.paymentType = paymentType
        }
    }

    struct Retrieve: Parametable {
        public var paymentType: PaymentType?
        public var startDate: Date?
        public var endDate: Date?
        
        public init(
            startDate: Date?,
            endDate: Date?,
            paymentType: PaymentType?
        ) {
            self.startDate = startDate
            self.endDate = endDate
            self.paymentType = paymentType
        }
    }
}


//MARK: - Responses -

public extension Cashbox.Responses {

    struct Full: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
        public var createDate: Date
        public var paymentType: PaymentType

        public init(
            id: UUID,
            createDate: Date,
            paymentType: PaymentType
        ){
            self.id = id
            self.createDate = createDate
            self.paymentType = paymentType
        }
    }
}
import Foundation

public enum Operation {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Operation.Parameters {
    struct Create: Parametable {
        public var price: Price
        public var infoType: OperationType
        public var paymentType: PaymentType

        public init(
            price: Price,
            infoType: OperationType,
            paymentType: PaymentType
        ){
            self.price = price
            self.infoType = infoType
            self.paymentType = paymentType
        }
    }
    
    struct Patch: Parametable {
        public var price: Price

        public init(
            price: Price
        ){
            self.price = price
        }
    }
}


//MARK: - Responses -

public extension Operation.Responses {

    struct Full: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID

        public init(
            id: UUID
        ){
            self.id = id
        }
    }
}
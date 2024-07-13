import Foundation

public enum Cashbox {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Cashbox.Parameters {
    struct Create: Parametable {
        public var paymentType: PaymentType

        public init(
            paymentType: PaymentType
        ){
            self.paymentType = paymentType
        }
    }
}


//MARK: - Responses -

public extension Cashbox.Responses {

    struct Full: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID

        public init(
            id: UUID
        ){
            self.id = id
        }
    }
}
import Foundation

public enum Cashbox {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Cashbox.Parameters {
    struct Create: Parametable {
        public var salonId: UUID

        public init(
            price: Price,
            info: [String : String],
            salonId: UUID
        ){
            self.salonId = salonId
        }
    }

    // struct Patch: Parametable {
    //     public var price: Price?
    //     public var info: [String : String]?

    //     public init(
    //         price: Price? = nil,
    //         info: [String : String]? = nil
    //     ){
    //         self.price = price
    //         self.info = info
    //     }
    // }
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
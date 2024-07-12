import Foundation

public enum Operation {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Operation.Parameters {
    struct Create: Parametable {
        public var price: Price
        public var info: [String : String]
        public var salonId: UUID

        public init(
            price: Price,
            info: [String : String],
            salonId: UUID
        ){
            self.price = price
            self.info = info
            self.salonId = salonId
        }
    }

    struct Patch: Parametable {
        public var price: Price?
        public var info: [String : String]?

        public init(
            price: Price? = nil,
            info: [String : String]? = nil
        ){
            self.price = price
            self.info = info
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
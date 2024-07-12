import Foundation

public enum Safebox {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Safebox.Parameters {
    struct Create: Parametable {
        public var currencies: [String]
        public var salonId: UUID

        public init(
            currencies: [String],
            salonId: UUID
        ){
            self.currencies = currencies
            self.salonId = salonId
        }
    }
}


//MARK: - Responses -

public extension Safebox.Responses {

    struct Full: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID

        public init(
            id: UUID
        ){
            self.id = id
        }
    }
}
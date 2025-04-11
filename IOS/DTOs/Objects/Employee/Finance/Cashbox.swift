import Foundation
import MemberwiseInit

public enum Cashbox {
    public enum Parameters {}
    public enum Responses {}
}

public extension Cashbox.Parameters {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Create: Parametable {
        public var salonId: UUID
        public var paymentType: PaymentType
    }

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Retrieve: Parametable {
        public var paymentType: PaymentType?
        public var startDate: Date?
        public var endDate: Date?
    }
}

public extension Cashbox.Responses {

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Full: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
        public var createDate: Date
        public var paymentType: PaymentType
    }
}

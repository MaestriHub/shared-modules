import Foundation
import MemberwiseInit

public enum Cashbox {
    public enum Parameters {}
    public enum Responses {}
}

public extension Cashbox.Parameters {
    
    @MemberwiseInit(.public)
    struct Create: Parametable {
        public var salonId: UUID
        public var paymentType: PaymentType
    }

    @MemberwiseInit(.public)
    struct Retrieve: Parametable {
        public var paymentType: PaymentType?
        public var startDate: Date?
        public var endDate: Date?
    }
}

public extension Cashbox.Responses {

    @MemberwiseInit(.public)
    struct Full: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
        public var createDate: Date
        public var paymentType: PaymentType
    }
}

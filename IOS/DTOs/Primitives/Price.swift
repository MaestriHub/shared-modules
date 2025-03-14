import Foundation
import MemberwiseInit

@MemberwiseInit(.public)
public struct Price: Parametable, Responsable, Hashable, Equatable {
    public var amount: Decimal
    public var currency: String
}

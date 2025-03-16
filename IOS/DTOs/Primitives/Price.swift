import Foundation
import MemberwiseInit

@MemberwiseInit(.public, _optionalsDefaultNil: true)
public struct Price: Parametable, Responsable, Hashable, Equatable {
    public var amount: Decimal
    public var currency: String
}

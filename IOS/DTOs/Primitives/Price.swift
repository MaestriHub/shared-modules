import Foundation
import MemberwiseInit

@MemberwiseInit(.public, _optionalsDefaultNil: true)
public struct Price: Codable, Hashable, Equatable, Sendable {
    public var amount: Decimal
    public var currency: String
}

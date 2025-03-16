import Foundation
import MemberwiseInit

@MemberwiseInit(.public, _optionalsDefaultNil: true)
public struct Wage: Codable, Hashable {
    public var price: Price
    public var period: PaymentPeriod
}

import Foundation
import MemberwiseInit

@MemberwiseInit(.public)
public struct Wage: Codable, Hashable {
    public var price: Price
    public var period: PaymentPeriod
}

import Foundation
import MemberwiseInit

@MemberwiseInit(.public)
public struct PaymentSubscriptionResponse: Codable, Sendable {
    public var title         : String
    public var logoURL       : String
    public var description   : String
    
    public var yearlyPrice   : Decimal
    public var yearlyPayURL  : String
    
    public var monthlyPrice  : Decimal
    public var monthlyPayURL : String
}

@MemberwiseInit(.public)
public struct SubscriptionResponse: Codable, Sendable {
    public var id: UUID
    public var stripeId: String?
    public var title: String
    public var startDate: Date
    public var endDate: Date
    public var price: Price
}

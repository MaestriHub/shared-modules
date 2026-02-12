import Foundation

public struct PaymentSubscriptionResponse: Codable, Sendable {
    public var title         : String
    public var logoURL       : String
    public var description   : String
    
    public var yearlyPrice   : Decimal
    public var yearlyPayURL  : String
    
    public var monthlyPrice  : Decimal
    public var monthlyPayURL : String
    
    public init(
        title: String,
        logoURL: String,
        description: String,
        yearlyPrice: Decimal,
        yearlyPayURL: String,
        monthlyPrice: Decimal,
        monthlyPayURL: String
    ) {
        self.title = title
        self.logoURL = logoURL
        self.description = description
        self.yearlyPrice = yearlyPrice
        self.yearlyPayURL = yearlyPayURL
        self.monthlyPrice = monthlyPrice
        self.monthlyPayURL = monthlyPayURL
    }
}

public struct SubscriptionResponse: Codable, Sendable {
    public var id: UUID
    public var stripeId: String?
    public var title: String
    public var startDate: Date
    public var endDate: Date
    public var price: Price
    
    public init(
        id: UUID,
        stripeId: String?,
        title: String,
        startDate: Date,
        endDate: Date,
        price: Price
    ) {
        self.id = id
        self.stripeId = stripeId
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.price = price
    }
}

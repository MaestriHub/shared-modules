import Foundation

public struct Price: Parametable, Responsable {
    
    public var amount: Decimal
    public var currency: String
    
    public init(amount: Decimal, currency: String) {
        self.amount = amount
        self.currency = currency
    }
}

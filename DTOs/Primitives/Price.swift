import Foundation

public struct Price: Parametable, Responsable {
    
    public var amount: Decimal
    public var currency: String
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.amount = try container.decode(Decimal.self, forKey: .amount)
        self.currency = try container.decode(String.self, forKey: .currency)
    }
}

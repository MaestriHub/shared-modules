import Foundation

public enum PriceShift: Codable, Sendable {
    case percent(Int)
    case absolute(Decimal)
    
    private enum CodingKeys: String, CodingKey {
        case percent
        case absolute
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let value = try? container.decode(Int.self, forKey: .percent) {
            self = .percent(value)
        } else if let value = try? container.decode(Decimal.self, forKey: .absolute) {
            self = .absolute(value)
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: CodingKeys.absolute,
                in: container,
                debugDescription: "Unable to decode PriceShift enum"
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .percent(let value):
            try container.encode(value, forKey: .percent)
        case .absolute(let value):
            try container.encode(value, forKey: .absolute)
        }
    }
}

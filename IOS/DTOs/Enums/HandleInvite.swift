import Foundation

public enum HandleInvite: Responsable, Hashable, Equatable {
    case successCustomer(Customer.Responses.Full)
    case requestVerify(Customer.Responses.Verify)
    
    enum CodingKeys: String, CodingKey {
        case successCustomer = "successCustomer"
        case requestVerify = "requestVerify"
    }

        // Декодирование
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let value = try? container.decode(Customer.Responses.Full.self, forKey: .successCustomer) {
            self = .successCustomer(value)
        } else if let value = try? container.decode(Customer.Responses.Verify.self, forKey: .requestVerify) {
            self = .requestVerify(value)
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: CodingKeys.successCustomer,
                in: container,
                debugDescription: "Unable to decode Foo enum"
            )
        }
    }

    // Кодирование
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .requestVerify(let value):
            try container.encode(value, forKey: .requestVerify)
        case .successCustomer(let value):
            try container.encode(value, forKey: .successCustomer)
        }
    }

}

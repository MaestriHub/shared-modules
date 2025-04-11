import Foundation

public enum HandleInvite: Responsable {
    case successCustomer(Client.Responses.Full)
    case requestVerify(Client.Responses.Verify)
    
    enum CodingKeys: String, CodingKey {
        case successCustomer = "successCustomer"
        case requestVerify = "requestVerify"
    }

        // Декодирование
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let value = try? container.decode(Client.Responses.Full.self, forKey: .successCustomer) {
            self = .successCustomer(value)
        } else if let value = try? container.decode(Client.Responses.Verify.self, forKey: .requestVerify) {
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

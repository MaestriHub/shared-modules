import Foundation

public enum ProfessionalEmployee: Responsable, Equatable {
    case link(URL)
    case value(Professional.Responses.Partial)
    
    enum CodingKeys: String, CodingKey {
        case link = "link"
        case value = "value"
    }

        // Декодирование
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let value = try? container.decode(URL.self, forKey: .link) {
            self = .link(value)
        } else if let value = try? container.decode(Professional.Responses.Partial.self, forKey: .value) {
            self = .value(value)
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: CodingKeys.link,
                in: container,
                debugDescription: "Unable to decode Foo enum"
            )
        }
    }

    // Кодирование
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .link(let value):
            try container.encode(value, forKey: .link)
        case .value(let value):
            try container.encode(value, forKey: .value)
        }
    }

}

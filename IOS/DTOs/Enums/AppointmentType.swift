import Foundation

public enum AppointmentType: Codable {
    case complex(Complex)
    case procedure(UUID)
    
    public typealias ChunkId = UUID
    public typealias ProcedureId = UUID
    public struct Complex: Codable {
        public let id: UUID
        public let order: [ChunkId : ProcedureId]
        
        public init(
            id: UUID,
            order: [ChunkId : ProcedureId]
        ) {
            self.id = id
            self.order = order
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case complex = "complex"
        case procedure = "procedure"
    }

        // Декодирование
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let value = try? container.decode(Complex.self, forKey: .complex) {
            self = .complex(value)
        } else if let value = try? container.decode(UUID.self, forKey: .procedure) {
            self = .procedure(value)
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: CodingKeys.complex,
                in: container,
                debugDescription: "Unable to decode AppointmentType enum"
            )
        }
    }

    // Кодирование
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .complex(let value):
            try container.encode(value, forKey: .complex)
        case .procedure(let value):
            try container.encode(value, forKey: .procedure)
        }
    }
}

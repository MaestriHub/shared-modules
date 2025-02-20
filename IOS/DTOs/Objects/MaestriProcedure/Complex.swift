import Foundation
import MemberwiseInit

public enum Complex {
    public enum Helpers {}
    
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Complex.Parameters {
    
    @MemberwiseInit(.public)
    struct All: Parametable {
        public let salonsFilter: [UUID]?
        public let employeesFilter: [UUID]?
        public let pagination: Pagination?
    }
    
    /// Пока комплекс можно создавать с помощью айдишников процедур, которые я копирую и делаю доступными только в комплексе.
    /// При запросе на все процедуры их не получить, а при запросе по id, их можно получить и подправить. (Если очень хочется).
    /// Думаю что в будущем добавиться возможность создавать комплекс не с айдишниками процедур, а с его личными
    /// процедурами, это в том случае, если таких процедур нет как явления, но в комплексе они существуют
    @MemberwiseInit(.public)
    struct Create: Parametable {
        public let alias: String?
        public let description: String?
        public let priceShift: Complex.Helpers.PriceShift
        public let chunks: [Complex.Helpers.CreateChunkRequest]
    }
    
    @MemberwiseInit(.public)
    struct Update: Parametable {
        public typealias ChunkPosition = Int
        public typealias ChunkId = UUID
    
        public let priceShift: Complex.Helpers.PriceShift?
        public let description: UpdateString?
        public let alias: UpdateString?
        public let shuffleChunks: [ChunkId : ChunkPosition]?
    }
}

// MARK: - Responses -

public extension Complex.Responses {
    
    @MemberwiseInit(.public)
    struct Create: Responsable {
        public let id: UUID
        public let priceShift: Complex.Helpers.PriceShift
        public let description: String?
        public let alias: String?
        public let chunks: [Complex.Helpers.ChunkResponse]
    }
    
    @MemberwiseInit(.public)
    struct Update: Responsable {
        public let id: UUID
        public let alias: String?
        public let description: String?
        public let priceShift: Complex.Helpers.PriceShift
        public let chunks: [Complex.Helpers.ChunkResponse]
    }
    
    @MemberwiseInit(.public)
    struct All: Responsable {
        public let complexes: [Complex.Helpers.ComplexResponse]
    }
    
    @MemberwiseInit(.public)
    struct Retrieve: Responsable {
        public let id: UUID
        public let alias: String?
        public let description: String?
        public let priceShift: Complex.Helpers.PriceShift
        public let chunks: [Complex.Helpers.ChunkResponse]
    }
}

public extension Complex.Helpers {
    
    @MemberwiseInit(.public)
    struct CreateChunkRequest: Codable {
        public let order: Int
        public let proceduresIds: [UUID]
    }
}

public extension Complex.Helpers {
    
    @MemberwiseInit(.public)
    struct ComplexResponse: Codable {
        public let id: UUID
        public let alias: String?
        public let description: String?
        public let priceShift: PriceShift
        public let chunks: [ChunkResponse]
    }
    
    @MemberwiseInit(.public)
    struct ChunkResponse: Codable {
        public let id: UUID
        public let order: Int
        public let procedures: [ProcedureResponse]
        public let serviceId: UUID
        public let serviceTitle: String
    }
    
    @MemberwiseInit(.public)
    struct ProcedureResponse: Codable {
        public let id: UUID
        public let alias: String?
        public let description: String?
        public let masterId: UUID
        public let masterNickname: String
        public let masterAvatar: URL?
    }
}

public extension Complex.Helpers {
    enum PriceShift: Codable {
        case percent(Decimal)
        case absolute(Decimal)
        
        private enum CodingKeys: String, CodingKey {
            case percent
            case absolute
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            if let value = try? container.decode(Decimal.self, forKey: .percent) {
                self = .percent(value)
            } else if let value = try? container.decode(Decimal.self, forKey: .absolute) {
                self = .absolute(value)
            } else {
                throw DecodingError.dataCorruptedError(
                    forKey: CodingKeys.absolute,
                    in: container,
                    debugDescription: "Unable to decode Foo enum"
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
}

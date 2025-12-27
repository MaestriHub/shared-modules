import Foundation

public enum Complex {
    public enum Helpers {}
    
    public enum Parameters {}
    public enum Responses {}
}

public typealias ComplexChunkId = UUID

// MARK: - Parameters -

public extension Complex.Parameters {
    
    struct All: Codable, Sendable {
        public let salonsFilter: [UUID]?
        public let employeesFilter: [UUID]?
        public let pagination: Pagination?
        
        public init(salonsFilter: [UUID]? = nil, employeesFilter: [UUID]? = nil, pagination: Pagination? = nil) {
            self.salonsFilter = salonsFilter
            self.employeesFilter = employeesFilter
            self.pagination = pagination
        }
    }
    
    /// Пока комплекс можно создавать с помощью айдишников процедур, которые я копирую и делаю доступными только в комплексе
    /// При запросе на все процедуры их не получить, а при запросе по id, их можно получить и подправить. (Если очень хочется).
    /// Думаю что в будущем добавиться возможность создавать комплекс не с айдишниками процедур, а с его личными
    /// процедурами, это в том случае, если таких процедур нет как явления, но в комплексе они существуют
    struct Create: Codable, Sendable {
        public let alias: String?
        public let description: String?
        public let priceShift: Complex.Helpers.PriceShift
        public let chunks: [Complex.Helpers.CreateChunkRequest]
        
        public init(
            alias: String? = nil,
            description: String? = nil,
            priceShift: Complex.Helpers.PriceShift,
            chunks: [Complex.Helpers.CreateChunkRequest]
        ) {
            self.alias = alias
            self.description = description
            self.priceShift = priceShift
            self.chunks = chunks
        }
    }
    
    struct Update: Codable, Sendable {
        public typealias ChunkPosition = Int
    
        public let priceShift: Complex.Helpers.PriceShift?
        public let description: UpdateString?
        public let alias: UpdateString?
        public let shuffleChunks: [ComplexChunkId : ChunkPosition]?
        
        public init(
            priceShift: Complex.Helpers.PriceShift? = nil,
            description: UpdateString? = nil,
            alias: UpdateString? = nil,
            shuffleChunks: [ComplexChunkId : ChunkPosition]? = nil
        ) {
            self.priceShift = priceShift
            self.description = description
            self.alias = alias
            self.shuffleChunks = shuffleChunks
        }
    }
}

// MARK: - Responses -

public extension Complex.Responses {
    
    struct Create: Codable, Sendable {
        public let id: UUID
        public let priceShift: Complex.Helpers.PriceShift
        public let description: String?
        public let alias: String?
        public let chunks: [Complex.Helpers.ChunkResponse]
        
        public init(
            id: UUID,
            priceShift: Complex.Helpers.PriceShift,
            description: String? = nil,
            alias: String? = nil,
            chunks: [Complex.Helpers.ChunkResponse]
        ) {
            self.id = id
            self.priceShift = priceShift
            self.description = description
            self.alias = alias
            self.chunks = chunks
        }
    }
    
    struct Update: Codable, Sendable {
        public let id: UUID
        public let alias: String?
        public let description: String?
        public let priceShift: Complex.Helpers.PriceShift
        public let chunks: [Complex.Helpers.ChunkResponse]
        
        public init(
            id: UUID,
            alias: String? = nil,
            description: String? = nil,
            priceShift: Complex.Helpers.PriceShift,
            chunks: [Complex.Helpers.ChunkResponse]
        ) {
            self.id = id
            self.alias = alias
            self.description = description
            self.priceShift = priceShift
            self.chunks = chunks
        }
    }
    
    struct All: Codable, Sendable {
        public let complexes: [Complex.Helpers.ComplexResponse]
        
        public init(complexes: [Complex.Helpers.ComplexResponse]) {
            self.complexes = complexes
        }
    }
    
    struct Retrieve: Codable, Sendable {
        public let id: UUID
        public let alias: String?
        public let description: String?
        public let priceShift: Complex.Helpers.PriceShift
        public let chunks: [Complex.Helpers.ChunkResponse]
        
        public init(
            id: UUID,
            alias: String? = nil,
            description: String? = nil,
            priceShift: Complex.Helpers.PriceShift,
            chunks: [Complex.Helpers.ChunkResponse]
        ) {
            self.id = id
            self.alias = alias
            self.description = description
            self.priceShift = priceShift
            self.chunks = chunks
        }
    }
}

public extension Complex.Helpers {
    
    struct CreateChunkRequest: Codable, Sendable {
        public let order: Int
        public let proceduresIds: [UUID]
        
        public init(order: Int, proceduresIds: [UUID]) {
            self.order = order
            self.proceduresIds = proceduresIds
        }
    }
}

public extension Complex.Helpers {
    
    struct ComplexResponse: Codable, Sendable {
        public let id: UUID
        public let alias: String?
        public let description: String?
        public let priceShift: PriceShift
        public let chunks: [ChunkResponse]
        
        public init(
            id: UUID,
            alias: String? = nil,
            description: String? = nil,
            priceShift: PriceShift,
            chunks: [ChunkResponse]
        ) {
            self.id = id
            self.alias = alias
            self.description = description
            self.priceShift = priceShift
            self.chunks = chunks
        }
    }
    
    struct ChunkResponse: Codable, Sendable {
        public let id: UUID
        public let order: Int
        public let procedures: [ProcedureResponse]
        public let serviceId: UUID
        public let serviceTitle: String
        public let serviceTags: [TranslatedServiceTag]
        
        public init(
            id: UUID,
            order: Int,
            procedures: [ProcedureResponse],
            serviceId: UUID,
            serviceTitle: String,
            serviceTags: [TranslatedServiceTag]
        ) {
            self.id = id
            self.order = order
            self.procedures = procedures
            self.serviceId = serviceId
            self.serviceTitle = serviceTitle
            self.serviceTags = serviceTags
        }
    }
    
    struct ProcedureResponse: Codable, Sendable {
        public let id: UUID
        public let alias: String?
        public let description: String?
        public let masterId: UUID
        public let masterNickname: String
        public let masterAvatar: URL
        public let duration: Minutes
        public let price: Price
        
        public init(
            id: UUID,
            alias: String? = nil,
            description: String? = nil,
            masterId: UUID,
            masterNickname: String,
            masterAvatar: URL,
            duration: Minutes,
            price: Price
        ) {
            self.id = id
            self.alias = alias
            self.description = description
            self.masterId = masterId
            self.masterNickname = masterNickname
            self.masterAvatar = masterAvatar
            self.duration = duration
            self.price = price
        }
    }
}

public extension Complex.Helpers {
    enum PriceShift: Codable, Sendable {
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

import Foundation

public enum Complex {
    public enum Helpers {}
    
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Complex.Parameters {
    
    struct All: Parametable {
        public let salonsFilter: [UUID]?
        public let employeesFilter: [UUID]?
        public let pagination: Pagination?
        
        public init(
            salons: [UUID]? = nil,
            employees: [UUID]? = nil,
            pagination: Pagination? = nil
        ) {
            self.salonsFilter = salons
            self.employeesFilter = employees
            self.pagination = pagination
        }
    }
    
    /// Пока комплекс можно создавать с помощью айдишников процедур, которые я копирую и делаю доступными только в комплексе.
    /// При запросе на все процедуры их не получить, а при запросе по id, их можно получить и подправить. (Если очень хочется).
    /// Думаю что в будущем добавиться возможность создавать комплекс не с айдишниками процедур, а с его личными
    /// процедурами, это в том случае, если таких процедур нет как явления, но в комплексе они существуют
    struct Create: Parametable {
        public let alias: String?
        public let description: String?
        public let priceShift: Complex.Helpers.PriceShift
        public let chunks: [Complex.Helpers.ChunkRequest]
        
        public init(
            alias: String?,
            description: String?,
            priceShift: Complex.Helpers.PriceShift,
            chunks: [Complex.Helpers.ChunkRequest]
        ) {
            self.alias = alias
            self.description = description
            self.priceShift = priceShift
            self.chunks = chunks
        }
    }
    
    struct Update: Parametable {
        public typealias ChunkPosition = Int
        public typealias ChunkId = UUID
    
        public let priceShift: Complex.Helpers.PriceShift?
        public let description: UpdateString?
        public let alias: UpdateString?
        public let shuffleChunks: [ChunkId : ChunkPosition]?
        
        public init(
            priceShift: Complex.Helpers.PriceShift?,
            description: UpdateString?,
            alias: UpdateString?,
            shuffleChunks: [ChunkId : ChunkPosition]
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
    
    struct Create: Responsable {
        public let id: UUID
        public let priceShift: Complex.Helpers.PriceShift
        public let description: String?
        public let alias: String?
        public let chunks: [Complex.Helpers.ChunkResponse]
        
        public init(
            id: UUID,
            priceShift: Complex.Helpers.PriceShift,
            description: String?,
            alias: String?,
            chunks: [Complex.Helpers.ChunkResponse]
        ) {
            self.id = id
            self.priceShift = priceShift
            self.description = description
            self.alias = alias
            self.chunks = chunks
        }
    }
    
    struct Update: Responsable {
        public let id: UUID
        public let alias: String?
        public let description: String?
        public let priceShift: Complex.Helpers.PriceShift
        public let chunks: [Complex.Helpers.ChunkResponse]
        
        public init(
            id: UUID,
            alias: String?,
            description: String?,
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
    
    struct All: Responsable {
        public let complexes: [Complex.Helpers.ComplexResponse]
        
        public init(
            complexes: [Complex.Helpers.ComplexResponse]
        ) {
            self.complexes = complexes
        }
    }
    
    struct Retrieve: Responsable {
        public let id: UUID
        public let alias: String?
        public let description: String?
        public let priceShift: Complex.Helpers.PriceShift
        public let chunks: [Complex.Helpers.ChunkResponse]
        
        public init(
            id: UUID,
            alias: String?,
            description: String?,
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
    struct ComplexResponse: Codable {
        public let id: UUID
        public let alias: String?
        public let description: String?
        public let priceShift: PriceShift
        public let chunks: [ChunkResponse]
        
        public init(
            id: UUID,
            alias: String?,
            description: String?,
            priceShift: PriceShift,
            chunks: [ChunkResponse]
        ) {
            self.id = id
            self.priceShift = priceShift
            self.description = description
            self.alias = alias
            self.chunks = chunks
        }
    }
    
    struct ChunkResponse: Codable {
        public let id: UUID
        public let order: Int
        public let procedures: [ProcedureResponse]
        public let serviceId: UUID
        public let serviceTitle: String
        
        public init(
            id: UUID,
            order: Int,
            procedures: [ProcedureResponse],
            serviceId: UUID,
            serviceTitle: String
        ) {
            self.id = id
            self.order = order
            self.procedures = procedures
            self.serviceId = serviceId
            self.serviceTitle = serviceTitle
        }
    }
    
    struct ProcedureResponse: Codable {
        public let id: UUID
        public let alias: String?
        public let description: String?
        public let masterId: UUID
        public let masterNickname: String
        public let masterAvatar: URL?
        
        public init(
            id: UUID,
            alias: String? = nil,
            description: String? = nil,
            masterId: UUID,
            masterNickname: String,
            masterAvatar: URL? = nil
        ) {
            self.id = id
            self.alias = alias
            self.description = description
            self.masterId = masterId
            self.masterNickname = masterNickname
            self.masterAvatar = masterAvatar
        }
    }
}

public extension Complex.Helpers { // TODO: вероятно здесь нужно будет добавить декодер ибо $0_
    enum CasePrice: Codable {
        case fixedValue(Decimal)
        case multiKoeff(Decimal)
        case none
    }

    enum CaseDuration: Codable {
        case fixedValue(Minutes)
        case multiKoeff(Decimal)
        case none
    }
}

public extension Complex.Helpers { // TODO: вероятно здесь нужно будет добавить декодер ибо $0_
    enum PriceShift: Codable {
        case percent(Decimal)
        case absolute(Decimal)
    }
    
    struct ChunkRequest: Codable {
        public let order: Int
        public let proceduresIds: [UUID]
        
        public init(
            order: Int,
            proceduresIds: [UUID]
        ) {
            self.order = order
            self.proceduresIds = proceduresIds
        }
    }
}

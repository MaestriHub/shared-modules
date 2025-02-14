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
        public let sale: Complex.Helpers.PriceShift
        public let description: String?
        public let alias: String?
        public let chunks: [Complex.Helpers.ChunkRequest]
        
        public init(
            sale: Complex.Helpers.PriceShift,
            description: String?,
            alias: String?,
            chunks: [Complex.Helpers.ChunkRequest]
        ) {
            self.sale = sale
            self.description = description
            self.alias = alias
            self.chunks = chunks
        }
    }
    
    struct Update: Parametable {
        public typealias ChunkPosition = Int
        public typealias ChunkId = UUID
    
        public let sale: Complex.Helpers.PriceShift?
        public var description: String?
        public var alias: String?
        public var shuffleChunks: [ChunkId : ChunkPosition]?
        
        public init(
            sale: Complex.Helpers.PriceShift?,
            description: String?,
            alias: String?,
            shuffleChunks: [ChunkId : ChunkPosition]
        ) {
            self.sale = sale
            self.description = description
            self.alias = alias
            self.shuffleChunks = shuffleChunks
        }
    }
}

// MARK: - Responses -

public extension Complex.Responses {
    
    struct Create: Responsable {
        public var id: UUID
        public var sale: Complex.Helpers.PriceShift
        public var description: String?
        public var alias: String?
        public let chunks: [Complex.Helpers.ChunkResponse]
        
        public init(
            id: UUID,
            sale: Complex.Helpers.PriceShift,
            description: String?,
            alias: String?,
            chunks: [Complex.Helpers.ChunkResponse]
        ) {
            self.id = id
            self.sale = sale
            self.description = description
            self.alias = alias
            self.chunks = chunks
        }
    }
    
    struct Update: Responsable {
        public var id: UUID
        public var sale: Complex.Helpers.PriceShift
        public var description: String?
        public var alias: String?
        public let chunks: [Complex.Helpers.ChunkResponse]
        
        public init(
            id: UUID,
            sale: Complex.Helpers.PriceShift,
            description: String?,
            alias: String?,
            chunks: [Complex.Helpers.ChunkResponse]
        ) {
            self.id = id
            self.sale = sale
            self.description = description
            self.alias = alias
            self.chunks = chunks
        }
    }
    
    struct All: Responsable {
        public var complexes:  [Complex.Helpers.ComplexResponse]
        // TODO: виталя просил добавить мастера.
        
        public init(
            complexes: [Complex.Helpers.ComplexResponse]
        ) {
            self.complexes = complexes
        }
    }
    
    struct Retrieve: Responsable {
        public var id: UUID
        public var sale: Complex.Helpers.PriceShift
        public var description: String?
        public var alias: String?
        public let chunks: [Complex.Helpers.ChunkResponse]
        
        public init(
            id: UUID,
            sale: Complex.Helpers.PriceShift,
            description: String?,
            alias: String?,
            chunks: [Complex.Helpers.ChunkResponse]
        ) {
            self.id = id
            self.sale = sale
            self.description = description
            self.alias = alias
            self.chunks = chunks
        }
    }
}

public extension Complex.Helpers {
    struct ComplexResponse: Codable {
        public var id: UUID
        public var sale: PriceShift
        public var description: String?
        public var alias: String?
        public var chunks: [ChunkResponse]
        
        public init(
            id: UUID,
            sale: PriceShift,
            description: String?,
            alias: String?,
            chunks: [ChunkResponse]
        ) {
            self.id = id
            self.sale = sale
            self.description = description
            self.alias = alias
            self.chunks = chunks
        }
    }
    
    struct ChunkResponse: Codable {
        public var id: UUID
        public var position: Int
        public var procedures: [ProcedureResponse]
        public var serviceId: UUID
        public var serviceTitle: String
        public var tags: [TranslatedServiceTag]
        
        public init(
            id: UUID,
            position: Int,
            procedures: [ProcedureResponse],
            serviceId: UUID,
            serviceTitle: String,
            tags: [TranslatedServiceTag]
        ) {
            self.id = id
            self.position = position
            self.procedures = procedures
            self.serviceId = serviceId
            self.serviceTitle = serviceTitle
            self.tags = tags
        }
    }
    
    struct ProcedureResponse: Codable {
        public var id: UUID
        public var alias: String?
        public var description: String?
        public var serviceId: UUID
        
        public init(
            id: UUID,
            alias: String? = nil,
            description: String? = nil,
            serviceId: UUID
        ) {
            self.id = id
            self.alias = alias
            self.description = description
            self.serviceId = serviceId
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
        case fixedValue(Decimal)
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

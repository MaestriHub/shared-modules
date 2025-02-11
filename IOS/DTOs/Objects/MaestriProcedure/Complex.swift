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
        public typealias ProcedureId = UUID
    
        public let sale: Complex.Helpers.PriceShift?
        public var description: String?
        public var alias: String?
        public var shuffleChunks: [ChunkId : ChunkPosition]?
        public var addProceduresToChunk: [ChunkId : [ProcedureId]]?
        
        public init(
            sale: Complex.Helpers.PriceShift?,
            description: String?,
            alias: String?,
            shuffleChunks: Dictionary<ChunkId, ChunkPosition>,
            addProceduresToChunk: Dictionary<ChunkId, [ProcedureId]>
        ) {
            self.sale = sale
            self.description = description
            self.alias = alias
            self.shuffleChunks = shuffleChunks
            self.addProceduresToChunk = addProceduresToChunk
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
        public var services:   [Complex.Helpers.ServiceResponse] // TODO: вероятно здесь может быть много повторов подумать потом
        
        public init(
            complexes: [Complex.Helpers.ComplexResponse],
            services:  [Complex.Helpers.ServiceResponse]
        ) {
            self.complexes = complexes
            self.services = services
        }
    }
    
    struct Retrieve: Responsable {
        public var id: UUID
        public var sale: Complex.Helpers.PriceShift
        public var description: String?
        public var alias: String?
        public let chunks: [Complex.Helpers.ChunkResponse]
        public let services: [Complex.Helpers.ServiceResponse]
        
        public init(
            id: UUID,
            sale: Complex.Helpers.PriceShift,
            description: String?,
            alias: String?,
            chunks: [Complex.Helpers.ChunkResponse],
            services: [Complex.Helpers.ServiceResponse]
        ) {
            self.id = id
            self.sale = sale
            self.description = description
            self.alias = alias
            self.chunks = chunks
            self.services = services
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
        
        public init(
            id: UUID,
            position: Int,
            procedures: [ProcedureResponse]
        ) {
            self.id = id
            self.position = position
            self.procedures = procedures
        }
    }
    
    struct ProcedureResponse: Codable {
        public var id: UUID
        public var alias: String?
        public var description: String?
        public var parameters: [ParameterResponse]
        public var serviceId: UUID
        
        public init(
            id: UUID,
            alias: String? = nil,
            description: String? = nil,
            parameters: [ParameterResponse],
            serviceId: UUID
        ) {
            self.id = id
            self.alias = alias
            self.description = description
            self.parameters = parameters
            self.serviceId = serviceId
        }
    }
    
    struct ServiceResponse: Codable {
        public var id: UUID
        public var title: String
        public var tags: [TranslatedServiceTag]
        
        public init(
            id: UUID,
            title: String,
            tags: [TranslatedServiceTag]
        ) {
            self.id = id
            self.title = title
            self.tags = tags
        }
    }
}

public extension Complex.Helpers {
    struct ParameterResponse: Codable {
        public let id: UUID
        public let optional: Bool
        public let title: String
        public let cases: [CaseResponse]
        
        public init(
            id: UUID,
            optional: Bool,
            title: String,
            cases: [CaseResponse]
        ) {
            self.id = id
            self.optional = optional
            self.title = title
            self.cases = cases
        }
    }
    
    struct CaseResponse: Codable {
        public let id: Int
        public let title: String
        public let price: CasePrice
        public let duration: CaseDuration
        
        public init(
            id: Int,
            title: String,
            price: CasePrice,
            duration: CaseDuration
        ) {
            self.id = id
            self.title = title
            self.price = price
            self.duration = duration
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
        let order: Int
        let proceduresIds: [UUID]
        
        public init(
            order: Int,
            proceduresIds: [UUID]
        ) {
            self.order = order
            self.proceduresIds = proceduresIds
        }
    }
}

import Foundation

public enum Complex {
    public enum Helpers {}
    
    public enum Parameters {}
    
    public enum Responses {
        public enum Helpers {}
    }
}

// MARK: - Helpers -

public extension Complex.Helpers {
    enum Sale: Codable {
        case percent(Decimal)
        case absolute(Decimal)
    }

    enum ExecutionType: Codable {
        case parallel
        case sequential
    }
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
        public let sale: Complex.Helpers.Sale
        public let description: String?
        public let alias: String?
        public let proceduresForCopy: [UUID]
        
        public init(
            sale: Complex.Helpers.Sale,
            description: String?,
            alias: String?,
            proceduresForCopy: [UUID]
        ) {
            self.sale = sale
            self.description = description
            self.alias = alias
            self.proceduresForCopy = proceduresForCopy
        }
    }
    
    struct Update: Parametable {
        public let sale: Complex.Helpers.Sale?
        public var description: String?
        public var alias: String?
        
        public init(
            sale: Complex.Helpers.Sale?,
            description: String?,
            alias: String?
        ) {
            self.sale = sale
            self.description = description
            self.alias = alias
        }
    }
}

// MARK: - Responses -

public extension Complex.Responses {
    
    struct Create: Responsable {
        public var id: UUID
        public var sale: Complex.Helpers.Sale
        public var description: String?
        public var alias: String?
        public let procedureIds: [UUID]
        
        public init(
            id: UUID,
            sale: Complex.Helpers.Sale,
            description: String?,
            alias: String?,
            procedureIds: [UUID]
        ) {
            self.id = id
            self.sale = sale
            self.description = description
            self.alias = alias
            self.procedureIds = procedureIds
        }
    }
    
    struct Update: Responsable {
        public var id: UUID
        public var sale: Complex.Helpers.Sale
        public var description: String?
        public var alias: String?
        
        public init(
            id: UUID,
            sale: Complex.Helpers.Sale,
            description: String?,
            alias: String?
        ) {
            self.id = id
            self.sale = sale
            self.description = description
            self.alias = alias
        }
    }
    
    struct All: Responsable {
        public var complexes:  [Helpers.Complex]
        public var procedures: [Helpers.Procedure]
        public var services:   [Helpers.Service]
        
        public init(
            complexes: [Helpers.Complex],
            procedures: [Helpers.Procedure],
            services: [Helpers.Service]
        ) {
            self.complexes = complexes
            self.procedures = procedures
            self.services = services
        }
    }
    
    struct Retrieve: Responsable {
        public var id: UUID
        public var sale: Complex.Helpers.Sale
        public var description: String?
        public var alias: String?
        
        public init(
            id: UUID,
            sale: Complex.Helpers.Sale,
            description: String?,
            alias: String?
        ) {
            self.id = id
            self.sale = sale
            self.description = description
            self.alias = alias
        }
    }
}

public extension Complex.Responses.Helpers {
    struct Complex: Codable {
        public var id: UUID
        public var sale: DTOs.Complex.Helpers.Sale
        public var description: String?
        public var alias: String?
        
        public init(
            id: UUID,
            sale: DTOs.Complex.Helpers.Sale,
            description: String?,
            alias: String?
        ) {
            self.id = id
            self.sale = sale
            self.description = description
            self.alias = alias
        }
    }
    
    struct Procedure: Codable {
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
    
    struct Service: Codable {
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

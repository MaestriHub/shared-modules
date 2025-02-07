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
        case percent(Double)
        case absolute(Double)
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
    
    struct Create: Parametable {
        public let sale: Complex.Helpers.Sale
        public let executionType: Complex.Helpers.ExecutionType
        public let duration: Int
        public let description: String?
        public let alias: String?
        public let procedureIds: [UUID]
        
        public init(
            sale: Complex.Helpers.Sale,
            executionType: Complex.Helpers.ExecutionType,
            duration: Int,
            description: String?,
            alias: String?,
            procedureIds: [UUID]
        ) {
            self.sale = sale
            self.executionType = executionType
            self.duration = duration
            self.description = description
            self.alias = alias
            self.procedureIds = procedureIds
        }
    }
    
    struct Update: Parametable {
        public let sale: Complex.Helpers.Sale?
        public let duration: Int?
        public var description: String?
        public var alias: String?
        
        public init(
            sale: Complex.Helpers.Sale?,
            duration: Int?,
            description: String?,
            alias: String?
        ) {
            self.sale = sale
            self.duration = duration
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
        public var executionType: Complex.Helpers.ExecutionType
        public var duration: Int
        public var description: String?
        public var alias: String?
        public let procedureIds: [UUID]
        
        public init(
            id: UUID,
            sale: Complex.Helpers.Sale,
            executionType: Complex.Helpers.ExecutionType,
            duration: Int,
            description: String?,
            alias: String?,
            procedureIds: [UUID]
        ) {
            self.id = id
            self.sale = sale
            self.executionType = executionType
            self.duration = duration
            self.description = description
            self.alias = alias
            self.procedureIds = procedureIds
        }
    }
    
    struct Update: Responsable {
        public var id: UUID
        public var sale: Complex.Helpers.Sale
        public var duration: Int
        public var description: String?
        public var alias: String?
        
        public init(
            id: UUID,
            sale: Complex.Helpers.Sale,
            duration: Int,
            description: String?,
            alias: String?
        ) {
            self.id = id
            self.sale = sale
            self.duration = duration
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
        public var executionType: Complex.Helpers.ExecutionType
        public var duration: Int
        public var description: String?
        public var alias: String?
        
        public init(
            id: UUID,
            sale: Complex.Helpers.Sale,
            executionType: Complex.Helpers.ExecutionType,
            duration: Int,
            description: String?,
            alias: String?
        ) {
            self.id = id
            self.sale = sale
            self.executionType = executionType
            self.duration = duration
            self.description = description
            self.alias = alias
        }
    }
}

public extension Complex.Responses.Helpers {
    struct Complex: Codable {
        public var id: UUID
        public var sale: DTOs.Complex.Helpers.Sale
        public var executionType: DTOs.Complex.Helpers.ExecutionType
        public var duration: Int
        public var description: String?
        public var alias: String?
        
        public init(
            id: UUID,
            sale: DTOs.Complex.Helpers.Sale,
            executionType: DTOs.Complex.Helpers.ExecutionType,
            duration: Int,
            description: String?,
            alias: String?
        ) {
            self.id = id
            self.sale = sale
            self.executionType = executionType
            self.duration = duration
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

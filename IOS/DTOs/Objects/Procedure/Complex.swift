import Foundation

public enum Complex {
    public enum Parameters {}
    public enum Responses {}
}

public extension Complex.Responses {
    enum Helpers {}
}

// MARK: - Parameters -

public extension Complex.Parameters {
    
    struct All: Parametable {
        public let salonsFilter: [UUID]?
        public let employeesFilter: [UUID]?
        
        public init(
            salons: [UUID]? = nil,
            employees: [UUID]? = nil
        ) {
            self.salonsFilter = salons
            self.employeesFilter = employees
        }
    }
    
    struct Create: Parametable {
        public let price: Price
        public let duration: Int
        public var description: String?
        public var alias: String?
        public let procedureIds: [UUID]
        
        public init(
            price: Price,
            duration: Int,
            description: String?,
            alias: String?,
            procedureIds: [UUID]
        ) {
            self.price = price
            self.duration = duration
            self.description = description
            self.alias = alias
            self.procedureIds = procedureIds
        }
    }
    
    struct Update: Parametable {
        public let price: Price
        public let duration: Int
        public var description: String?
        public var alias: String?
        
        public init(
            price: Price,
            duration: Int,
            description: String?,
            alias: String?
        ) {
            self.price = price
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
        public var price: Price
        public var duration: Int
        public var description: String?
        public var alias: String?
        public let procedureIds: [UUID]
        
        public init(
            id: UUID,
            price: Price,
            duration: Int,
            description: String?,
            alias: String?,
            procedureIds: [UUID]
        ) {
            self.id = id
            self.price = price
            self.duration = duration
            self.description = description
            self.alias = alias
            self.procedureIds = procedureIds
        }
    }
    
    struct Update: Responsable {
        public var id: UUID
        public var price: Price
        public var duration: Int
        public var description: String?
        public var alias: String?
        
        public init(
            id: UUID,
            price: Price,
            duration: Int,
            description: String?,
            alias: String?
        ) {
            self.id = id
            self.price = price
            self.duration = duration
            self.description = description
            self.alias = alias
        }
    }
    
    struct All: Responsable {
        public var id: UUID
        public var price: Price
        public var duration: Int
        public var description: String?
        public var alias: String?
        public var procedures: [Helpers.Procedure]
        public var services: [Helpers.Service]
        
        public init(
            id: UUID,
            price: Price,
            duration: Int,
            description: String?,
            alias: String?,
            procedures: [Helpers.Procedure],
            services: [Helpers.Service]
        ) {
            self.id = id
            self.price = price
            self.duration = duration
            self.description = description
            self.alias = alias
            self.procedures = procedures
            self.services = services
        }
    }
    
    struct Retrieve: Responsable {
        public var id: UUID
        public var price: Price
        public var duration: Int
        public var description: String?
        public var alias: String?
        
        public init(
            id: UUID,
            price: Price,
            duration: Int,
            description: String?,
            alias: String?
        ) {
            self.id = id
            self.price = price
            self.duration = duration
            self.description = description
            self.alias = alias
        }
    }
}

public extension Complex.Responses.Helpers {
    struct Procedure: Codable {
        var id: UUID
        var alias: String?
        var description: String?
        var serviceId: UUID
        
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
        var id: UUID
        var title: String
        var tags: [ServiceTags]
        
        public init(
            id: UUID,
            title: String,
            tags: [ServiceTags]
        ) {
            self.id = id
            self.title = title
            self.tags = tags
        }
    }
}

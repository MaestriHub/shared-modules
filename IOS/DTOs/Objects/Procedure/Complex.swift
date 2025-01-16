import Foundation

public enum Complex {
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Complex.Parameters {
    
    struct All: Parametable {
        public let salonsFilter: [UUID]
        public let employeesFilter: [UUID]
        
        public init(
            salons: [UUID] = [],
            employees: [UUID] = []
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
        // TODO: процедуры
        
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

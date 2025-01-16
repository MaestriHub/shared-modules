import Foundation

public enum Procedure {
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Procedure.Parameters {
    
    struct All: Parametable {
        public let salonsFilter: [UUID]
        public let employeesFilter: [UUID]
        public let servicesFilter: [UUID]
        public let addMastersInfo: Bool
        
        public init(
            salons: [UUID] = [],
            employees: [UUID] = [],
            services: [UUID] = [],
            addMastersInfo: Bool = false
        ) {
            self.salonsFilter = salons
            self.employeesFilter = employees
            self.servicesFilter = services
            self.addMastersInfo = addMastersInfo
        }
    }

    struct Create: Parametable {
        public let price: Price
        public let duration: Int
        public var description: String?
        public var alias: String?
        public let serviceId: UUID
        public let employeeId: UUID
        
        public init(
            price: Price,
            duration: Int,
            description: String?,
            alias: String?,
            serviceId: UUID,
            employeeId: UUID
        ) {
            self.price = price
            self.duration = duration
            self.description = description
            self.alias = alias
            self.serviceId = serviceId
            self.employeeId = employeeId
        }
    }

    struct Update: Parametable {
        public let price: Price?
        public let duration: Int?
        public var description: String?
        public var alias: String?
        
        public init(
            price: Price?,
            duration: Int?,
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

public extension Procedure.Responses {
    
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
    
    struct Retrieve: Responsable {
        public var id: UUID
        public var price: Price
        public var duration: Int
        public var description: String?
        public var alias: String?
        // TODO: добавить сервис ?
        // TODO: добавить работника?
        
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
        // TODO: добавить сервисов?
        // TODO: добавить работников?
        
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

import Foundation

public enum Procedure {
    public enum Parameters {}
    public enum Responses {}
}

public extension Procedure.Responses {
    enum Helpers {}
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
        public let duration: Int
        public let price: Price
        public var description: String?
        public var alias: String?
        public let serviceId: UUID
        public let employeeId: UUID
        
        public init(
            duration: Int,
            price: Price,
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
    
    struct All: Responsable {
        public var procedures: [Helpers.Procedure]
        public var services: [Helpers.Service]
        public var masters: [Helpers.Masters]?
        
        public init(
            procedures: [Helpers.Procedure],
            services: [Helpers.Service],
            masters: [Helpers.Masters]? = nil
        ) {
            self.procedures = procedures
            self.services = services
            self.masters = masters
        }
    }
    
    struct Retrieve: Responsable {
        public var id: UUID
        public var duration: Int
        public var price: Price
        public var alias: String?
        public var description: String?
        
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

public extension Procedure.Responses.Helpers {
    struct Procedure: Codable {
        public var id: UUID
        public var duration: Int
        public var price: Price
        public var alias: String?
        public var description: String?
    }
    
    struct Service: Codable {
        public var id: UUID
        public var tags: ServiceTags // TODO:
        public var title: String
    }
    
    struct Masters: Codable {
        public var id: UUID
        public var nickname: String?
        public var photo: String?
    }
}

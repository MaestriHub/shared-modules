import Foundation

public enum Procedure {
    public enum Helpers {}
    
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Procedure.Parameters {
    
    struct All: Parametable {
        public let salonsFilter: [UUID]?
        public let employeesFilter: [UUID]?
        public let servicesFilter: [UUID]?
        public let addMastersInfo: Bool
        public let pagination: Pagination?
        
        public init(
            salons: [UUID]? = nil,
            employees: [UUID]? = nil,
            services: [UUID]? = nil,
            addMastersInfo: Bool = false,
            pagination: Pagination? = nil
        ) {
            self.salonsFilter = salons
            self.employeesFilter = employees
            self.servicesFilter = services
            self.addMastersInfo = addMastersInfo
            self.pagination = pagination
        }
    }

    struct Create: Parametable {
        public let duration: Int
        public let price: Price
        public var description: String?
        public var alias: String?
        public let parameters: [Procedure.Helpers.CreateParameterRequest]
        public let serviceId: UUID
        public let employeeId: UUID
        
        public init(
            duration: Int,
            price: Price,
            description: String?,
            alias: String?,
            parameters: [Procedure.Helpers.CreateParameterRequest],
            serviceId: UUID,
            employeeId: UUID
        ) {
            self.price = price
            self.duration = duration
            self.description = description
            self.alias = alias
            self.parameters = parameters
            self.serviceId = serviceId
            self.employeeId = employeeId
        }
    }

    struct Update: Parametable {
        public let price: Price?
        public let duration: Int?
        public var description: String?
        public var alias: String?
        public let parameters: [Procedure.Helpers.UpdateParameterRequest]?
        
        public init(
            price: Price?,
            duration: Int?,
            description: String?,
            alias: String?,
            parameters: [Procedure.Helpers.UpdateParameterRequest]?
        ) {
            self.price = price
            self.duration = duration
            self.description = description
            self.alias = alias
            self.parameters = parameters
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
        public var parameters: [Procedure.Helpers.ParameterResponse]
        public var serviceId: UUID
        public var employeeId: UUID
        
        public init(
            id: UUID,
            price: Price,
            duration: Int,
            description: String?,
            alias: String?,
            parameters: [Procedure.Helpers.ParameterResponse],
            serviceId: UUID,
            employeeId: UUID
        ) {
            self.id = id
            self.price = price
            self.duration = duration
            self.description = description
            self.alias = alias
            self.parameters = parameters
            self.serviceId = serviceId
            self.employeeId = employeeId
        }
    }
    
    struct Update: Responsable {
        public var id: UUID
        public var price: Price
        public var duration: Int
        public var description: String?
        public var alias: String?
        public var parameters: [Procedure.Helpers.ParameterResponse]
        public var serviceId: UUID
        public var employeeId: UUID
        
        public init(
            id: UUID,
            price: Price,
            duration: Int,
            description: String?,
            alias: String?,
            parameters: [Procedure.Helpers.ParameterResponse],
            serviceId: UUID,
            employeeId: UUID
        ) {
            self.id = id
            self.price = price
            self.duration = duration
            self.description = description
            self.alias = alias
            self.parameters = parameters
            self.serviceId = serviceId
            self.employeeId = employeeId
        }
    }
    
    struct All: Responsable {
        public var procedures: [Procedure.Helpers.ProcedureResponse]
        public var services: [Procedure.Helpers.ServiceResponse]
        public var masters: [Procedure.Helpers.MastersResponse]?
        
        public init(
            procedures: [Procedure.Helpers.ProcedureResponse],
            services: [Procedure.Helpers.ServiceResponse],
            masters: [Procedure.Helpers.MastersResponse]? = nil
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
        public var parameters: [Procedure.Helpers.ParameterResponse]
        public var serviceId: UUID
        public var employeeId: UUID
        
        public init(
            id: UUID,
            price: Price,
            duration: Int,
            description: String?,
            alias: String?,
            parameters: [Procedure.Helpers.ParameterResponse],
            serviceId: UUID,
            employeeId: UUID
        ) {
            self.id = id
            self.price = price
            self.duration = duration
            self.description = description
            self.alias = alias
            self.parameters = parameters
            self.serviceId = serviceId
            self.employeeId = employeeId
        }
    }
}

public extension Procedure.Helpers {
    struct ProcedureResponse: Codable {
        public var id: UUID
        public var duration: Int
        public var price: Price
        public var alias: String?
        public var description: String?
        public var parameters: Procedure.Helpers.ParameterResponse
        public var serviceId: UUID
        public var masterId: UUID
        
        public init(
            id: UUID,
            duration: Int,
            price: Price,
            alias: String? = nil,
            description: String? = nil,
            parameters: Procedure.Helpers.ParameterResponse,
            serviceId: UUID,
            masterId: UUID
        ) {
            self.id = id
            self.duration = duration
            self.price = price
            self.alias = alias
            self.description = description
            self.parameters = parameters
            self.serviceId = serviceId
            self.masterId = masterId
        }
    }
    
    struct ServiceResponse: Codable {
        public var id: UUID
        public var tags: [TranslatedServiceTag]
        public var title: String
        
        public init(
            id: UUID,
            tags: [TranslatedServiceTag],
            title: String
        ) {
            self.id = id
            self.tags = tags
            self.title = title
        }
    }
    
    struct MastersResponse: Codable {
        public var id: UUID
        public var nickname: String?
        public var avatar: String?
        
        public init(
            id: UUID,
            nickname: String? = nil,
            avatar: String? = nil
        ) {
            self.id = id
            self.nickname = nickname
            self.avatar = avatar
        }
    }
}

public extension Procedure.Helpers  {
    struct CreateParameterRequest: Codable {
        public let id: UUID
        public let optional: Bool
        public let cases: [CreateCaseRequest]
        
        public init(
            id: UUID,
            optional: Bool,
            cases: [CreateCaseRequest]
        ) {
            self.id = id
            self.optional = optional
            self.cases = cases
        }
    }
    
    struct CreateCaseRequest: Codable {
        public let id: Int
        public let addPriceToProcedure: CasePrice
        public let addDurationToProcedure: CaseDuration
        
        public init(
            id: Int,
            addPriceToProcedure: CasePrice,
            addDurationToProcedure: CaseDuration
        ) {
            self.id = id
            self.addPriceToProcedure = addPriceToProcedure
            self.addDurationToProcedure = addDurationToProcedure
        }
    }
    
    struct UpdateParameterRequest: Codable {
        public let id: UUID
        public let optional: Bool?
        public let cases: [UpdateCaseRequest]?
        
        public init(
            id: UUID,
            optional: Bool?,
            cases: [UpdateCaseRequest]?
        ) {
            self.id = id
            self.optional = optional
            self.cases = cases
        }
    }
    
    struct UpdateCaseRequest: Codable {
        public let id: Int
        public let addPriceToProcedure: CasePrice?
        public let addDurationToProcedure: CaseDuration?
        
        public init(
            id: Int,
            addPriceToProcedure: CasePrice?,
            addDurationToProcedure: CaseDuration?
        ) {
            self.id = id
            self.addPriceToProcedure = addPriceToProcedure
            self.addDurationToProcedure = addDurationToProcedure
        }
    }
}

public extension Procedure.Helpers {
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


public extension Procedure.Helpers { // TODO: декодеры
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

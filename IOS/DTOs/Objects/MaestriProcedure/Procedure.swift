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
        public let duration: Minutes
        public let price: Price
        public let description: String?
        public let alias: String?
        public let parameters: [Procedure.Helpers.CreateParameterRequest]
        public let serviceId: UUID
        public let employeeIds: [UUID]
        
        public init(
            duration: Minutes,
            price: Price,
            description: String?,
            alias: String?,
            parameters: [Procedure.Helpers.CreateParameterRequest],
            serviceId: UUID,
            employeeIds: [UUID]
        ) {
            self.price = price
            self.duration = duration
            self.description = description
            self.alias = alias
            self.parameters = parameters
            self.serviceId = serviceId
            self.employeeIds = employeeIds
        }
    }
    
    struct Update: Parametable {
        public let price: Price?
        public let duration: Minutes?
        public let description: UpdateString?
        public let alias: UpdateString?
        
        public init(
            price: Price?,
            duration: Minutes?,
            description: UpdateString?,
            alias: UpdateString?
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
        public let procedures: [Procedure.Helpers.CreateProcedureResponse]
        
        public init(
            procedures: [Procedure.Helpers.CreateProcedureResponse]
        ) {
            self.procedures = procedures
        }
    }
    
    struct Update: Responsable {
        public let id: UUID
        public let price: Price
        public let duration: Minutes
        public let description: String?
        public let alias: String?
        public let parameters: [Procedure.Helpers.ParameterResponse]
        public let serviceId: UUID
        public let serviceTags: [TranslatedServiceTag]
        public let serviceTitle: String
        public let masterId: UUID
        public let masterNickname: String
        public let masterAvatar: URL?
        
        public init(
            id: UUID,
            price: Price,
            duration: Minutes,
            description: String? = nil,
            alias: String? = nil,
            parameters: [Procedure.Helpers.ParameterResponse],
            serviceId: UUID,
            serviceTags: [TranslatedServiceTag],
            serviceTitle: String,
            masterId: UUID,
            masterNickname: String,
            masterAvatar: URL? = nil
        ) {
            self.id = id
            self.price = price
            self.duration = duration
            self.description = description
            self.alias = alias
            self.parameters = parameters
            self.serviceId = serviceId
            self.serviceTags = serviceTags
            self.serviceTitle = serviceTitle
            self.masterId = masterId
            self.masterNickname = masterNickname
            self.masterAvatar = masterAvatar
        }
    }
    
    struct All: Responsable {
        public let procedures: [Procedure.Helpers.ProcedureResponse]
        
        public init(
            procedures: [Procedure.Helpers.ProcedureResponse]
        ) {
            self.procedures = procedures
        }
    }
    
    struct Retrieve: Responsable {
        public let id: UUID
        public let duration: Minutes
        public let price: Price
        public let alias: String?
        public let description: String?
        public let parameters: [Procedure.Helpers.ParameterResponse]
        public let serviceId: UUID
        public let serviceTags: [TranslatedServiceTag]
        public let serviceTitle: String
        public let masterId: UUID
        public let masterNickname: String
        public let masterAvatar: URL?
        
        public init(
            id: UUID,
            duration: Minutes,
            price: Price,
            alias: String? = nil,
            description: String? = nil,
            parameters: [Procedure.Helpers.ParameterResponse],
            serviceId: UUID,
            serviceTags: [TranslatedServiceTag],
            serviceTitle: String,
            masterId: UUID,
            masterNickname: String,
            masterAvatar: URL? = nil
        ) {
            self.id = id
            self.duration = duration
            self.price = price
            self.alias = alias
            self.description = description
            self.parameters = parameters
            self.serviceId = serviceId
            self.serviceTags = serviceTags
            self.serviceTitle = serviceTitle
            self.masterId = masterId
            self.masterNickname = masterNickname
            self.masterAvatar = masterAvatar
        }
    }
}

public extension Procedure.Helpers {
    struct CreateProcedureResponse: Codable {
        public let id: UUID
        public let duration: Minutes
        public let price: Price
        public let alias: String?
        public let description: String?
        public let parameters: [Procedure.Helpers.ParameterResponse]
        public let serviceId: UUID
        public let serviceTags: [TranslatedServiceTag]
        public let serviceTitle: String
        public let masterId: UUID
        public let masterNickname: String
        public let masterAvatar: URL?
        
        public init(
            id: UUID,
            duration: Minutes,
            price: Price,
            alias: String? = nil,
            description: String? = nil,
            parameters: [Procedure.Helpers.ParameterResponse],
            serviceId: UUID,
            serviceTags: [TranslatedServiceTag],
            serviceTitle: String,
            masterId: UUID,
            masterNickname: String,
            masterAvatar: URL? = nil
        ) {
            self.id = id
            self.duration = duration
            self.price = price
            self.alias = alias
            self.description = description
            self.parameters = parameters
            self.serviceId = serviceId
            self.serviceTags = serviceTags
            self.serviceTitle = serviceTitle
            self.masterId = masterId
            self.masterNickname = masterNickname
            self.masterAvatar = masterAvatar
        }
    }
    
    struct ProcedureResponse: Codable {
        public let id: UUID
        public let duration: Minutes
        public let price: Price
        public let alias: String?
        public let description: String?
        public let parameters: [Procedure.Helpers.ParameterResponse]
        public let serviceId: UUID
        public let serviceTags: [TranslatedServiceTag]
        public let serviceTitle: String
        public let masterId: UUID
        public let masterNickname: String
        public let masterAvatar: URL?
        
        public init(
            id: UUID,
            duration: Minutes,
            price: Price,
            alias: String? = nil,
            description: String? = nil,
            parameters: [Procedure.Helpers.ParameterResponse],
            serviceId: UUID,
            serviceTags: [TranslatedServiceTag],
            serviceTitle: String,
            masterId: UUID,
            masterNickname: String,
            masterAvatar: URL? = nil
        ) {
            self.id = id
            self.duration = duration
            self.price = price
            self.alias = alias
            self.description = description
            self.parameters = parameters
            self.serviceId = serviceId
            self.serviceTags = serviceTags
            self.serviceTitle = serviceTitle
            self.masterId = masterId
            self.masterNickname = masterNickname
            self.masterAvatar = masterAvatar
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
        public let casePrice: CasePrice
        public let caseDuration: CaseDuration
        
        public init(
            id: Int,
            casePrice: CasePrice,
            caseDuration: CaseDuration
        ) {
            self.id = id
            self.casePrice = casePrice
            self.caseDuration = caseDuration
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


public extension Procedure.Helpers {
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

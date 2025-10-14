import Foundation

public enum Procedure {
    public enum Helpers {}
    
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Procedure.Parameters {
    
    struct All: Codable, Sendable {
        public let salonsFilter: [UUID]?
        public let employeesFilter: [UUID]?
        public let pagination: Pagination?
        
        public init(salonsFilter: [UUID]? = nil, employeesFilter: [UUID]? = nil, pagination: Pagination? = nil) {
            self.salonsFilter = salonsFilter
            self.employeesFilter = employeesFilter
            self.pagination = pagination
        }
    }
    
    struct Create: Codable, Sendable {
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
            description: String? = nil,
            alias: String? = nil,
            parameters: [Procedure.Helpers.CreateParameterRequest],
            serviceId: UUID,
            employeeIds: [UUID]
        ) {
            self.duration = duration
            self.price = price
            self.description = description
            self.alias = alias
            self.parameters = parameters
            self.serviceId = serviceId
            self.employeeIds = employeeIds
        }
    }
    
    struct Update: Codable, Sendable {
        public let price: Price?
        public let duration: Minutes?
        public let description: UpdateString?
        public let alias: UpdateString?
        
        public init(
            price: Price? = nil,
            duration: Minutes? = nil,
            description: UpdateString? = nil,
            alias: UpdateString? = nil
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
    
    struct Create: Codable, Sendable {
        public let procedures: [Procedure.Helpers.CreateProcedureResponse]
        
        public init(procedures: [Procedure.Helpers.CreateProcedureResponse]) {
            self.procedures = procedures
        }
    }
    
    struct All: Codable, Sendable {
        public let procedures: [Procedure.Helpers.AllProcedureResponse]
        
        public init(procedures: [Procedure.Helpers.AllProcedureResponse]) {
            self.procedures = procedures
        }
    }
    
    struct Update: Codable, Sendable {
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
        public let masterAvatar: URL
        
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
            masterAvatar: URL
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
    
    struct Retrieve: Codable, Sendable {
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
        public let masterAvatar: URL
        
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
            masterAvatar: URL
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
    
    struct CreateParameterRequest: Codable, Sendable {
        public let id: UUID
        public let optional: Bool
        public let cases: [CreateCaseRequest]
        
        public init(id: UUID, optional: Bool, cases: [CreateCaseRequest]) {
            self.id = id
            self.optional = optional
            self.cases = cases
        }
    }
    
    struct CreateCaseRequest: Codable, Sendable {
        public let id: Int
        public let casePrice: CasePrice?
        public let caseDuration: CaseDuration?
        
        public init(id: Int, casePrice: CasePrice? = nil, caseDuration: CaseDuration? = nil) {
            self.id = id
            self.casePrice = casePrice
            self.caseDuration = caseDuration
        }
    }
    
    struct CreateProcedureResponse: Codable, Sendable {
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
        public let masterAvatar: URL
        
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
            masterAvatar: URL
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
    
    struct AllProcedureResponse: Codable, Sendable {
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
        public let masterAvatar: URL
        
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
            masterAvatar: URL
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
    struct ParameterResponse: Codable, Sendable {
        public let id: UUID
        public let optional: Bool
        public let title: String
        public let cases: [CaseResponse]
        
        public init(id: UUID, optional: Bool, title: String, cases: [CaseResponse]) {
            self.id = id
            self.optional = optional
            self.title = title
            self.cases = cases
        }
    }
    
    struct CaseResponse: Codable, Sendable {
        public let id: Int
        public let title: String
        public let price: CasePrice?
        public let duration: CaseDuration?
        
        public init(id: Int, title: String, price: CasePrice? = nil, duration: CaseDuration? = nil) {
            self.id = id
            self.title = title
            self.price = price
            self.duration = duration
        }
    }
    
    enum CasePrice: Codable, Sendable {
        case fixedValue(Decimal)
        case multiKoeff(Decimal)
        
        private enum CodingKeys: String, CodingKey {
            case fixedValue
            case multiKoeff
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            if let value = try? container.decode(Decimal.self, forKey: .fixedValue) {
                self = .fixedValue(value)
            } else if let value = try? container.decode(Decimal.self, forKey: .multiKoeff) {
                self = .multiKoeff(value)
            } else {
                throw DecodingError.dataCorruptedError(
                    forKey: CodingKeys.fixedValue,
                    in: container,
                    debugDescription: "Unable to decode Foo enum"
                )
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch self {
            case .fixedValue(let value):
                try container.encode(value, forKey: .fixedValue)
            case .multiKoeff(let value):
                try container.encode(value, forKey: .multiKoeff)
            }
        }
    }
    
    enum CaseDuration: Codable, Sendable {
        case fixedValue(Minutes)
        case multiKoeff(Decimal)
        
        private enum CodingKeys: String, CodingKey {
            case fixedValue
            case multiKoeff
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            if let value = try? container.decode(Minutes.self, forKey: .fixedValue) {
                self = .fixedValue(value)
            } else if let value = try? container.decode(Decimal.self, forKey: .multiKoeff) {
                self = .multiKoeff(value)
            } else {
                throw DecodingError.dataCorruptedError(
                    forKey: CodingKeys.fixedValue,
                    in: container,
                    debugDescription: "Unable to decode Foo enum"
                )
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch self {
            case .fixedValue(let value):
                try container.encode(value, forKey: .fixedValue)
            case .multiKoeff(let value):
                try container.encode(value, forKey: .multiKoeff)
            }
        }
    }
}

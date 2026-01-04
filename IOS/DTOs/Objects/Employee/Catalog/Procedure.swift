import Foundation

public enum Procedure {
    public enum Helpers {}
    
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Procedure.Parameters {
    
    struct All: Codable, Sendable {
        public let salonFilter: UUID?
        public let employeeFilter: UUID?
        public let pagination: Pagination?
        
        public init(salonFilter: UUID? = nil, employeeFilter: UUID? = nil, pagination: Pagination? = nil) {
            self.salonFilter = salonFilter
            self.employeeFilter = employeeFilter
            self.pagination = pagination
        }
    }
    
    struct Create: Codable, Sendable {
        public let alias: String?
        public let description: String?
        public let duration: Minutes
        public let price: Price
        public let serviceId: UUID
        public let employeeIds: [UUID]
        
        public init(
            alias: String? = nil,
            description: String? = nil,
            duration: Minutes,
            price: Price,
            serviceId: UUID,
            employeeIds: [UUID]
        ) {
            self.alias = alias
            self.description = description
            self.duration = duration
            self.price = price
            self.serviceId = serviceId
            self.employeeIds = employeeIds
        }
    }
    
    struct Update: Codable, Sendable {
        public let alias: String?
        public let description: String?
        public let duration: Minutes?
        public let price: Price?
        
        public init(
            alias: String? = nil,
            description: String? = nil,
            duration: Minutes? = nil,
            price: Price? = nil
        ) {
            self.alias = alias
            self.description = description
            self.duration = duration
            self.price = price
        }
    }
}

// MARK: - Responses -

public extension Procedure.Responses {

    typealias Create = Procedure.Helpers.ProcedureResponse
    
    typealias All = [Procedure.Helpers.ProcedureResponse]

    typealias Update = Procedure.Helpers.ProcedureResponse
    
    typealias Retrieve = Procedure.Helpers.ProcedureResponse
}

public extension Procedure.Helpers  {
    
    /// Структура процедуры с массивом executions
    struct ProcedureResponse: Codable, Sendable {
        public let id: UUID
        public let title: String
        public let description: String?
        public let serviceId: UUID
        public let serviceTags: [TranslatedServiceTag]
        public let serviceTitle: String
        public let minDuration: Minutes
        public let minPrice: Price
        public let currency: String
        public let executions: [ExecutionResponse]
        
        public init(
            id: UUID,
            title: String,
            description: String? = nil,
            serviceId: UUID,
            serviceTags: [TranslatedServiceTag],
            serviceTitle: String,
            minDuration: Minutes,
            minPrice: Price,
            currency: String,
            executions: [ExecutionResponse]
        ) {
            self.id = id
            self.title = title
            self.description = description
            self.serviceId = serviceId
            self.serviceTags = serviceTags
            self.serviceTitle = serviceTitle
            self.minDuration = minDuration
            self.minPrice = minPrice
            self.currency = currency
            self.executions = executions
        }
    }
    
    /// Структура execution в процедуре
    struct ExecutionResponse: Codable, Sendable {
        public let id: UUID
        public let price: Decimal
        public let duration: Minutes
        public let currency: String
        public let masterId: UUID
        public let masterName: String
        public let masterAvatar: URL
        
        public init(
            id: UUID,
            price: Decimal,
            duration: Minutes,
            currency: String,
            masterId: UUID,
            masterName: String,
            masterAvatar: URL
        ) {
            self.id = id
            self.price = price
            self.duration = duration
            self.currency = currency
            self.masterId = masterId
            self.masterName = masterName
            self.masterAvatar = masterAvatar
        }
    }
}

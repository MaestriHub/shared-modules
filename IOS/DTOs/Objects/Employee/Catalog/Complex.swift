import Foundation

public enum Complex {
    public enum Helpers {}
    
    public enum Parameters {}
    public enum Responses {}
}

public typealias ComplexChunkId = UUID

// MARK: - Parameters -

public extension Complex.Parameters {
    
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
        public let priceShift: Complex.Helpers.PriceShift
        public let procedures: [Complex.Helpers.CreateProcedure]
        
        public init(
            alias: String? = nil,
            description: String? = nil,
            priceShift: Complex.Helpers.PriceShift,
            procedures: [Complex.Helpers.CreateProcedure]
        ) {
            self.alias = alias
            self.description = description
            self.priceShift = priceShift
            self.procedures = procedures
        }
    }
    
    struct Update: Codable, Sendable {
        public let alias: String?
        public let description: String?
        public let priceShift: Complex.Helpers.PriceShift?
        
        public init(
            alias: String? = nil,
            description: String? = nil,
            priceShift: Complex.Helpers.PriceShift? = nil
        ) {
            self.alias = alias
            self.description = description
            self.priceShift = priceShift
        }
    }
}

// MARK: - Responses -

public extension Complex.Responses {

    typealias Create = Complex.Helpers.ComplexResponse
    
    typealias All = [Complex.Helpers.ComplexResponse]

    typealias Update = Complex.Helpers.ComplexResponse
    
    typealias Retrieve = Complex.Helpers.ComplexResponse
}

public extension Complex.Helpers {
    
    struct CreateProcedure: Codable, Sendable {
        public let alias: String?
        public let description: String?
        public let order: Int
        public let duration: Minutes
        public let price: Price
        public let serviceId: UUID
        public let employeeIds: [UUID]
        
        public init(
            alias: String? = nil,
            description: String? = nil,
            order: Int,
            duration: Minutes,
            price: Price,
            serviceId: UUID,
            employeeIds: [UUID]
        ) {
            self.alias = alias
            self.description = description
            self.order = order
            self.duration = duration
            self.price = price
            self.serviceId = serviceId
            self.employeeIds = employeeIds
        }
    }
}

public extension Complex.Helpers {
    
    struct ComplexResponse: Codable, Sendable {
        public let id: UUID
        public let title: String
        public let description: String?
        public let priceShift: PriceShift
        public let procedures: [ProcedureResponse]
        
        public init(
            id: UUID,
            title: String,
            description: String? = nil,
            priceShift: PriceShift,
            procedures: [ProcedureResponse]
        ) {
            self.id = id
            self.title = title
            self.description = description
            self.priceShift = priceShift
            self.procedures = procedures
        }
    }
    
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

public extension Complex.Helpers {
    enum PriceShift: Codable, Sendable {
        case percent(Decimal)
        case absolute(Decimal)
        
        private enum CodingKeys: String, CodingKey {
            case percent
            case absolute
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            if let value = try? container.decode(Decimal.self, forKey: .percent) {
                self = .percent(value)
            } else if let value = try? container.decode(Decimal.self, forKey: .absolute) {
                self = .absolute(value)
            } else {
                throw DecodingError.dataCorruptedError(
                    forKey: CodingKeys.absolute,
                    in: container,
                    debugDescription: "Unable to decode Foo enum"
                )
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch self {
            case .percent(let value):
                try container.encode(value, forKey: .percent)
            case .absolute(let value):
                try container.encode(value, forKey: .absolute)
            }
        }
    }
}

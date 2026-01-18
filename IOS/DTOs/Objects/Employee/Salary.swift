import Foundation
/*
public enum Salary {
    public enum Parameters {}
    public enum Responses {}
}

public extension Salary.Responses {
    enum Rules {}
    enum Balance {}
    enum Helpers {}
}

public extension Salary.Parameters {
    enum Rules {}
    enum Balance {}
    enum Helpers {}
}

public extension Salary.Parameters.Rules {
    
    struct Create: Codable, Sendable {
        public var percent: Int?
        public var grid: [UUID : SalaryPaymentType]?
        public var wage: Wage?
        
        public init(percent: Int? = nil, grid: [UUID : SalaryPaymentType]? = nil, wage: Wage? = nil) {
            self.percent = percent
            self.grid = grid
            self.wage = wage
        }
    }
}

public extension Salary.Parameters.Balance {
    
    struct Payout: Codable, Sendable {
        public var paymentType: PaymentType
        public var dateTo: Date
        
        public init(paymentType: PaymentType, dateTo: Date) {
            self.paymentType = paymentType
            self.dateTo = dateTo
        }
    }
    
    struct Calculate: Codable, Sendable {
        public var dateTo: Date
        
        public init(dateTo: Date) {
            self.dateTo = dateTo
        }
    }
}

public extension Salary.Responses.Rules {
    
    struct Full: Codable, Sendable {
        public var percent: Int?
        public var grid: [Salary.Responses.Helpers.ServiceWithPaymentType]?
        public var wage: Wage?
        
        public init(
            percent: Int? = nil,
            grid: [Salary.Responses.Helpers.ServiceWithPaymentType]? = nil,
            wage: Wage? = nil
        ) {
            self.percent = percent
            self.grid = grid
            self.wage = wage
        }
    }
}

public extension Salary.Responses.Balance {

    struct Full: Codable, Sendable {
        public var wage: Price?
        public var grid: [Price]?
        public var procent: [Price]?
        public var sum: [Price]
        
        public init(wage: Price? = nil, grid: [Price]? = nil, procent: [Price]? = nil, sum: [Price]) {
            self.wage = wage
            self.grid = grid
            self.procent = procent
            self.sum = sum
        }
    }
}

public extension Salary.Responses.Helpers {
    
    struct ServiceWithPaymentType: Codable, Sendable {
        public var service: Service
        public var paymentType: SalaryPaymentType
        
        public init(service: Service, paymentType: SalaryPaymentType) {
            self.service = service
            self.paymentType = paymentType
        }
    }
    
    struct Service: Codable, Sendable {
        public var id: UUID
        public var title: String
        public var description: String
        public var category: [ServiceTags]
        
        public init(id: UUID, title: String, description: String, category: [ServiceTags]) {
            self.id = id
            self.title = title
            self.description = description
            self.category = category
        }
    }
}
*/
import Foundation
import MemberwiseInit

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
    
    @MemberwiseInit(.public)
    struct Create: Parametable {
        public var percent: Int?
        public var grid: [UUID : SalaryPaymentType]?
        public var wage: Wage?
    }
}

public extension Salary.Parameters.Balance {
    
    @MemberwiseInit(.public)
    struct Payout: Parametable {
        public var paymentType: PaymentType
        public var dateTo: Date
    }
    
    @MemberwiseInit(.public)
    struct Calculate: Parametable {
        public var dateTo: Date
    }
}

public extension Salary.Responses.Rules {
    
    @MemberwiseInit(.public)
    struct Full: Responsable {
        public var percent: Int?
        public var grid: [Salary.Responses.Helpers.ServiceWithPaymentType]?
        public var wage: Wage?
    }
}

public extension Salary.Responses.Balance {

    @MemberwiseInit(.public)
    struct Full: Responsable {
        public var wage: Price?
        public var grid: [Price]?
        public var procent: [Price]?
        public var sum: [Price]
    }
}

public extension Salary.Responses.Helpers {
    
    @MemberwiseInit(.public)
    struct ServiceWithPaymentType: Codable {
        public var service: Service
        public var paymentType: SalaryPaymentType
    }
    
    @MemberwiseInit(.public)
    struct Service: Codable {
        public var id: UUID
        public var title: String
        public var description: String
        public var category: [ServiceTags]
    }
}

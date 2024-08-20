import Foundation

public enum Freebier {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Freebier.Parameters {
    
    struct Create: Parametable {
        // public let startDate: Date?
        // public let endDate: Date?
        // public let employees: [UUID]?
        // public let salons: [UUID]?
        // public let customer: UUID?
        
        public init(
        //     startDate: Date?,
        //     endDate: Date?,
        //     employees: [UUID]? = nil,
        //     salons: [UUID]? = nil,
        //     customer: UUID? = nil
        ) {
        //     self.startDate = startDate
        //     self.endDate = endDate
        //     self.employees = employees
        //     self.salons = salons
        //     self.customer = customer
        }
    }
    
    struct Patch: Parametable {
        // public let masterId: UUID
        // public let customerId: UUID?
        // public let proceduresId: [UUID]
        // public let time: DateInterval
        
        public init(
        //     masterId: UUID,
        //     customerId: UUID?,
        //     proceduresId: [UUID],
        //     time: DateInterval
        ) {
        //     self.masterId = masterId
        //     self.customerId = customerId
        //     self.proceduresId = proceduresId
        //     self.time = time
        }
    }
}

//MARK: - Responses -

public extension Freebier.Responses {
    
    struct Full: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
        // public var status: AppointmentStatus
        // public var salon: Salon.Responses.Partial
        // public var customer: Customer.Responses.Partial
        // public var master: Employee.Responses.Partial
        // public var procedures: [Procedure.Responses.Partial]
        // public var time: DateInterval
        // public var price: Price
        // public var address: Address
        
        public init(
            id: UUID
        //     status: AppointmentStatus,
        //     salon: Salon.Responses.Partial,
        //     customer: Customer.Responses.Partial,
        //     master: Employee.Responses.Partial,
        //     procedures: [Procedure.Responses.Partial],
        //     time: DateInterval,
        //     price: Price,
        //     address: Address
        ) {
            self.id = id
        //     self.status = status
        //     self.salon = salon
        //     self.customer = customer
        //     self.master = master
        //     self.procedures = procedures
        //     self.time = time
        //     self.price = price
        //     self.address = address
        }
    }
    
    struct Partial: Responsable, Identifiable, Equatable {
        public var id: UUID
        // public var status: AppointmentStatus
        // public var customer: Customer.Responses.Partial
        // public var master: Employee.Responses.Partial
        // public var time: DateInterval
        // public var price: Price
        // public var procedures: String
        
        public init(
            id: UUID
        //     status: AppointmentStatus,
        //     customer: Customer.Responses.Partial,
        //     master: Employee.Responses.Partial,
        //     time: DateInterval,
        //     price: Price,
        //     procedures: String
        ) {
            self.id = id
        //     self.status = status
        //     self.customer = customer
        //     self.master = master
        //     self.time = time
        //     self.price = price
        //     self.procedures = procedures
        }
    }
}

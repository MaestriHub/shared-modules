import Foundation
import MemberwiseInit

public enum AppointmentEmployee {
    public enum Parameters {}
    public enum Responses {}
}

public extension AppointmentEmployee.Responses {
    enum Helpers {}
}

public extension AppointmentEmployee.Parameters {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Retrieve: Parametable {
        public let startDate: Date?
        public let endDate: Date?
        public let employees: [UUID]?
        public let salons: [UUID]?
        public let customer: UUID?
    }

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Create: Parametable {
        public let customerId: UUID
        public let type: AppointmentType
        public let time: SafeDateInterval
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Approve: Parametable {
        public let appointmentsEmployeeId: [UUID]
    }

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Patch: Parametable {
        public let time: SafeDateInterval
    }
}

public extension AppointmentEmployee.Responses {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Full: Responsable {
        public var salon: Workspace.Responses.Partial
        public var customer: Customer.Responses.Partial
        public var address: Address
        public var associative: [Base]
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Partial: Responsable {
        public var customer: Customer.Responses.Partial
        public var associative: [Base]
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Base: Responsable {
        public var id: UUID
        public var status: AppointmentStatus
        public var procedure: Helpers.Procedure
        public var time: SafeDateInterval
        public var price: Price
    }
}

public extension AppointmentEmployee.Responses.Helpers {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Procedure: Codable {
        public var id: UUID
        public var description: String?
        public var alias: String?
        public var master: Master
        public var service: Service
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Service: Codable {
        public var id: UUID
        public var title: String
        public var category: [ServiceTags]
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Master: Codable {
        public var id: UUID
        public var nick: String
        public var avatar: URL?
        public var contacts: [Contact.Shared.PrimaryContact]
    }
}


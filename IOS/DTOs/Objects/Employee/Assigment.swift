import Foundation
import MemberwiseInit

public enum Assigment {
    public enum Parameters {}
    public enum Responses {}
}

public extension Assigment.Responses {
    enum Helpers {}
}

public extension Assigment.Parameters {
    
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

public extension Assigment.Responses {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Full: Responsable {
        public var customer: Assigment.Responses.Helpers.Client
        public var address: Address
        public var associative: [Base]
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Partial: Responsable {
        public var customer: Assigment.Responses.Helpers.Client
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

public extension Assigment.Responses.Helpers {
    
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
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Client: Codable {
        public var id: UUID
        public var nick: String
        public var avatar: URL?
        public var contacts: [Contact.Shared.PrimaryContact]
    }
}


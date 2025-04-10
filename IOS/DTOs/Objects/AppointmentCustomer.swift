import Foundation
import MemberwiseInit

public enum AppointmentCustomer {
    public enum Parameters {}
    public enum Responses {}
}

public extension AppointmentCustomer.Responses {
    enum Helpers {}
}

public extension AppointmentCustomer.Parameters {

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Retrieve: Parametable {
        public let startDate: Date?
        public let endDate: Date?
        public let employees: [UUID]?
        public let salons: [UUID]?
    }

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Create: Parametable {
        public let type: AppointmentType
        public let time: SafeDateInterval
    }

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Patch: Parametable {
        public let time: SafeDateInterval
    }
}

public extension AppointmentCustomer.Responses {

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Full: Responsable {
        public var id: UUID
        public var status: AppointmentStatus
        public var salon: Workspace.Responses.Partial // TODO:
        public var procedures: [Helpers.Procedure]
        public var time: SafeDateInterval
        public var price: Price
        public var address: Address
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Partial: Responsable {
        public var id: UUID
        public var status: AppointmentStatus
        public var time: SafeDateInterval
        public var price: Price
        public var procedures: [Helpers.Procedure]
    }
}

public extension AppointmentCustomer.Responses.Helpers {
    
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


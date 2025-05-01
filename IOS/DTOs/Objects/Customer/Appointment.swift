import Foundation
import MemberwiseInit

public enum Appointment {
    public enum Parameters {}
    public enum Responses {}
}

public extension Appointment.Responses {
    enum Helpers {}
}

public extension Appointment.Parameters {

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Retrieve: Codable {
        public let startDate: Date?
        public let endDate: Date?
        public let employees: [UUID]?
        public let salons: [UUID]?
    }

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Create: Codable {
        public let type: AppointmentType
        public let time: SafeDateInterval
    }

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Patch: Codable {
        public let time: SafeDateInterval
    }
}

public extension Appointment.Responses {

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Full: Codable {
        public var id: UUID
        public var status: AppointmentStatus
        public var salon: Helpers.Salon
        public var procedures: [Helpers.Procedure]
        public var time: SafeDateInterval
        public var price: Price
        public var address: Address
        public var point: CoordinatePoint
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Partial: Codable {
        public var id: UUID
        public var status: AppointmentStatus
        public var time: SafeDateInterval
        public var price: Price
        public var procedures: [Helpers.Procedure]
    }
}

public extension Appointment.Responses.Helpers {
    
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
        public var avatar: URL
        public var contacts: [Contact.Shared.PrimaryContact]
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Salon: Codable {
        public var id: UUID
        public var name: String
        public var type: SalonType
        public var logo: URL
        public var address: Address
        public var point: CoordinatePoint
    }
}


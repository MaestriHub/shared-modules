import Foundation
import MemberwiseInit

public enum Customer {
    public enum Parameters {}
    public enum Responses {}
}

public extension Customer.Parameters {
    
    @MemberwiseInit(.public)
    struct Registration: Parametable {
        public let contactValue: String
        public let contactType: ContactType
    }
    
    @MemberwiseInit(.public)
    struct Create: Parametable {
        public var salonId: UUID
        public var alias: String
        public let contactValue: String
        public let contactType: ContactType
    }
    
    @MemberwiseInit(.public)
    struct Retrieve: Parametable {
        public let salons: [UUID]?
        public let employees: [UUID]?
    }

    @MemberwiseInit(.public)
    struct HandleInvite: Parametable {
        public var contactValue: String?
    }
}

public extension Customer.Responses {
    
    @MemberwiseInit(.public)
    struct Full: Responsable {
        public var id: UUID
        public var user: CustomerUser
        public var alias: String?
        public var contacts: [Contact.Shared.PrimaryContact]
    }
    
    @MemberwiseInit(.public)
    struct Partial: Responsable {
        public var id: UUID
        public var user: CustomerUser
        public var alias: String?
        public var contacts: [Contact.Shared.PrimaryContact]
    }

    @MemberwiseInit(.public)
    struct Verify: Responsable {
        public var contacts: [Contact.Shared.PrimaryContact]
    }
}

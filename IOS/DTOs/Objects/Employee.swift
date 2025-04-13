import Foundation
import MemberwiseInit

public enum Employee {
    public enum Parameters {}
    public enum Responses {}
    
    public enum Internal {}
}

public extension Employee.Parameters {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Retrieve: Parametable {
        public let salonsId: [UUID]
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Invite: Parametable {
        public var nickname: String?
        public var salonId: UUID
        public var positionId: UUID
        public var contact: Employee.Internal.Contact?
        public var timetable: Timetable.Parameters.Create.Pattern?
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Patch: Parametable {
        public var positionId: UUID?
    }
}

public extension Employee.Responses {

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Full: Responsable {
        public var id: UUID
        public var user: ProfessionalEmployee
        public var canEdit: Bool = false
        public var contacts: [Contact.Shared.PrimaryContact]
        public var salonId: UUID
        public var position: Position.Responses.Full
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Partial: Responsable {
        public var id: UUID
        public var nickname: String
        public var avatar: URL?
        public var contacts: [Contact.Shared.PrimaryContact]
        public var position: Position.Responses.Partial
    }
}

public extension Employee.Internal {
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Contact: Codable {
        public var value: String
        public var type: ContactType
    }
}

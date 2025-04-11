import Foundation
import MemberwiseInit

public enum User {
    public enum Parameters {}
    public enum Responses {}
}

public extension User.Parameters {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Patch: Parametable {
        public var nickname: String?
        public var avatar: URL?
    }
}

public extension User.Responses {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Full: Responsable {
        public var id: UUID
        public var avatar: URL?
        public var nickname: String
        public var contacts: [Contact.Shared.RecoveryContact]
        public var options: UserRoleSet
        public var permissions: MaestriPermissionSet
        public var customerId: UUID?
        public var professionalId: UUID?
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Partial: Responsable {
        public var avatar: URL?
        public var nickname: String
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct CreateCustomer: Responsable {
        public var customerId: UUID
        public var accessToken: String
    }
}

import Foundation
import MemberwiseInit

public enum HandleInvite {
    public enum Parameters {}
    public enum Responses {}
    public enum Internal {}
}

public extension HandleInvite.Parameters {
  
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Customer: Parametable {
        public var contactValue: String?
    }
    
    // struct Employee: Parametable
    // Nothing!
}

public extension HandleInvite.Responses {

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct EmployeeSuccess: Responsable {
        public let id: UUID
        public let nickname: String
        public let logo: URL?
        public let position: String
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct CustomerSuccessOneOf: Responsable {
        public let verify: HandleInvite.Internal.Verify?
        public let client: HandleInvite.Internal.Client?
    }
}

public extension HandleInvite.Internal {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Verify: Responsable {
        public let contacts: [Contact.Shared.PrimaryContact]
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Client: Responsable {
        public let alias: String?
    }
}


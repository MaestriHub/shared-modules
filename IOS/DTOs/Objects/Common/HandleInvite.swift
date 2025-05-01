import Foundation
import MemberwiseInit

public enum HandleInvite {
    public enum Parameters {}
    public enum Responses {}
    public enum Internal {}
}

public extension HandleInvite.Parameters {
  
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Customer: Codable {
        public var contactValue: String?
    }
    
    // struct Employee: Codable
    // Nothing!
}

public extension HandleInvite.Responses {

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct EmployeeSuccess: Codable {
        public let id: UUID
        public let nickname: String
        public let logo: URL
        public let position: String
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct CustomerSuccessOneOf: Codable {
        public let verify: HandleInvite.Internal.Verify?
        public let client: HandleInvite.Internal.Client?
    }
}

public extension HandleInvite.Internal {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Verify: Codable {
        public let contacts: [Contact.Shared.PrimaryContact]
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Client: Codable {
        public let alias: String?
    }
}


import Foundation
import MemberwiseInit

public enum HandleInvite {
    public enum Parameters {}
    public enum Responses {}
    public enum Internal {}
}

public extension HandleInvite.Parameters {
  
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct ClientMerge: Codable, Sendable {
        public var contact: String
    }
}

public extension HandleInvite.Responses {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct EmployeeSuccess: Codable, Sendable {
        public let id: UUID
        public let nickname: String
        public let logo: URL
        public let position: String
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct MaskedContacts: Codable, Sendable {
        public let contacts: [String]
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct ClientMergeSuccess: Codable, Sendable {
        public let id: UUID
        public let alias: String?
    }
}

import Foundation
import MemberwiseInit

public enum HandleInvite {
    public enum Parameters {}
    public enum Responses {}
    public enum Internal {}
}

public extension HandleInvite.Parameters {
  
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct ClientMerge: Codable {
        public var contact: String
    }
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
    struct MaskedContact: Codable {
        public let contacts: [String]
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct ClientMergeSuccess: Codable {
        public let alias: String?
    }
}

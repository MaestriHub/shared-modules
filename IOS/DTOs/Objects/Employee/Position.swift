import Foundation
import MemberwiseInit

public enum Position {
    public enum Parameters {}
    public enum Responses {}
}

public extension Position.Parameters {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Create: Codable {
        public var title: String
        public var creds: CredentialsSet
        public var makeOwner: Bool
        public var salary: Salary.Parameters.Rules.Create
    }

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Patch: Codable {
        public var title: String?
        public var creds: CredentialsSet?
        public var makeOwner: Bool?
        public var salary: Salary.Parameters.Rules.Create?
    }
}

public extension Position.Responses {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Full: Codable {
        public var id: UUID
        public var title: String
        public var creds: CredentialsSet
        public var owner: Bool
        public var salary: Salary.Responses.Rules.Full
    }

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Partial: Codable {
        public var id: UUID
        public var title: String
    }
}

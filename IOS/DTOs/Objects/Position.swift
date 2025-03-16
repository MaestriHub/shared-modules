import Foundation
import MemberwiseInit

public enum Position {
    public enum Parameters {}
    public enum Responses {}
}

public extension Position.Parameters {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Create: Parametable {
        public var title: String
        public var permissions: PermissionSet
        public var salary: Salary.Parameters.Rules.Create
    }

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Patch: Parametable {
        public var title: String?
        public var permissions: PermissionSet?
        public var salary: Salary.Parameters.Rules.Create?
    }
}

public extension Position.Responses {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Full: Responsable {
        public var id: UUID
        public var title: String
        public var permissions: PermissionSet
        public var salary: Salary.Responses.Rules.Full
    }

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Partial: Responsable {
        public var id: UUID
        public var title: String
    }
}

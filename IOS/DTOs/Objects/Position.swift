import Foundation
import MemberwiseInit

public enum Position {
    public enum Parameters {}
    public enum Responses {}
}

public extension Position.Parameters {
    
    @MemberwiseInit(.public)
    struct Create: Parametable {
        public var title: String
        public var permissions: PermissionSet
        public var salary: Salary.Parameters.Rules.Create
    }

    @MemberwiseInit(.public)
    struct Patch: Parametable {
        public var title: String?
        public var permissions: PermissionSet?
        public var salary: Salary.Parameters.Rules.Create?
    }
}

public extension Position.Responses {
    
    @MemberwiseInit(.public)
    struct Full: Responsable {
        public var id: UUID
        public var title: String
        public var permissions: PermissionSet
        public var salary: Salary.Responses.Rules.Full
    }

    @MemberwiseInit(.public)
    struct Partial: Responsable {
        public var id: UUID
        public var title: String
    }
}

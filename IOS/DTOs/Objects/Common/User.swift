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
    struct UserInfo: Responsable {
        public var id: UUID
        public var avatar: URL?
        public var nickname: String
        public let haveCustomer: Bool
        public let haveEmployee: Bool
    }
}

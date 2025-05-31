import Foundation
import MemberwiseInit

public enum User {
    public enum Parameters {}
    public enum Responses {}
}

public extension User.Parameters {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Patch: Codable {
        public var nickname: String?
        public var avatar: URL?
    }
}

public extension User.Responses {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct AuthUser: Codable {
        public var id: UUID
        public var avatar: URL? // при первой регистрации эти поля могут не дойти
        public var nickname: String?
        public let contactExists: Bool
        public let haveCustomer: Bool
        public let haveEmployee: Bool
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct UserInfo: Codable {
        public var id: UUID
        public var avatar: URL
        public var nickname: String
        public let haveCustomer: Bool
        public let haveEmployee: Bool
    }
}

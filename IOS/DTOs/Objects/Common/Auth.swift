import Foundation
import MemberwiseInit

public enum Auth {
    public enum Parameters {}
    public enum Responses {}
    public enum Internal {}
}

public extension Auth.Parameters {
  
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct AppleToken: Codable, Sendable {
        public var token: String
        public var firstName: String?
        public var lastName: String?
        public var email: String?
        public var emailVerified: Bool?
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct GoogleToken: Codable, Sendable {
        public var token: String
        public var firstName: String?
        public var lastName: String?
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct RefreshingToken: Codable, Sendable {
        public var token: String
    }
}

public extension Auth.Responses {

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct SuccessAuth: Codable, Sendable {
        public let accessToken: Token
        public let refreshToken: Token
        public let user: Auth.Internal.UserInfo
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Refresh: Codable, Sendable {
        public let accessToken: Token
        public let refreshToken: Token?
    }
}

public extension Auth.Internal {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct UserInfo: Codable, Sendable {
        public let id: UUID
        public let avatar: URL?
        public let nickname: String?
        public let haveContact: Bool
        public let haveCustomer: Bool
        public let haveEmployee: Bool
    }
}

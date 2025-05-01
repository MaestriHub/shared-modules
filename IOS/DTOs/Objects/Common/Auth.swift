import Foundation
import MemberwiseInit

public enum Auth {
    public enum Parameters {}
    public enum Responses {}
    public enum Internal {}
}

public extension Auth.Parameters {
  
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct AppleToken: Codable {
        public var token: String
        public var firstName: String?
        public var lastName: String?
        public var email: String?
        public var emailVerified: Bool?
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct GoogleToken: Codable {
        public var token: String
        public var firstName: String?
        public var lastName: String?
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct RefreshingToken: Codable {
        public var token: String
    }
}

public extension Auth.Responses {

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct SuccessAuth: Codable {
        public let accessToken: Token
        public let refreshToken: Token
        public let user: Auth.Internal.UserInfo
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Refresh: Codable {
        public let accessToken: Token
        public let refreshToken: Token?
    }
}

public extension Auth.Internal {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct UserInfo: Codable {
        public let id: UUID
        public let avatar: URL?
        public let nickname: String?
        public let haveCustomer: Bool
        public let haveEmployee: Bool
    }
}

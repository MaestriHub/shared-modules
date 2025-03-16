import Foundation
import MemberwiseInit

public enum Auth {
    public enum Parameters {}
    public enum Responses {}
}

public extension Auth.Parameters {
  
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct AppleToken: Parametable {
        public var token: String
        public var firstName: String?
        public var lastName: String?
        public var email: String?
        public var emailVerified: Bool?
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct GoogleToken: Parametable {
        public var token: String
        public var firstName: String?
        public var lastName: String?
    }
}

public extension Auth.Responses {

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Full: Responsable {
        public let accessToken: Token
        public let refreshToken: Token
        public let user: User.Responses.Full
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Partial: Responsable {
        public let accessToken: Token
        public let refreshToken: Token?
    }
}

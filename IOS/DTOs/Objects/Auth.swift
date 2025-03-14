import Foundation
import MemberwiseInit

public enum Auth {
    public enum Parameters {}
    public enum Responses {}
}

public extension Auth.Parameters {
  
    @MemberwiseInit(.public)
    struct AppleToken: Parametable {
        public var token: String
        public var firstName: String?
        public var lastName: String?
        public var email: String?
        public var emailVerified: Bool?
    }
    
    @MemberwiseInit(.public)
    struct GoogleToken: Parametable {
        public var token: String
        public var firstName: String?
        public var lastName: String?
    }
}

public extension Auth.Responses {

    @MemberwiseInit(.public)
    struct Full: Responsable {
        public let accessToken: Token
        public let refreshToken: Token
        public let user: User.Responses.Full
    }
    
    @MemberwiseInit(.public)
    struct Partial: Responsable {
        public let accessToken: Token
        public let refreshToken: Token?
    }
}

import Foundation

public enum Auth {
    public enum Parameters {}
    public enum Responses {}
    public enum Internal {}
}

public extension Auth.Parameters {
  
    struct AppleToken: Codable, Sendable {
        public var token: String
        public var firstName: String?
        public var lastName: String?
        public var email: String?
        public var emailVerified: Bool?
        
        public init(
            token: String,
            firstName: String? = nil,
            lastName: String? = nil,
            email: String? = nil,
            emailVerified: Bool? = nil
        ) {
            self.token = token
            self.firstName = firstName
            self.lastName = lastName
            self.email = email
            self.emailVerified = emailVerified
        }
    }
    
    struct GoogleToken: Codable, Sendable {
        public var token: String
        public var firstName: String?
        public var lastName: String?
        
        public init(token: String, firstName: String? = nil, lastName: String? = nil) {
            self.token = token
            self.firstName = firstName
            self.lastName = lastName
        }
    }
    
    struct RefreshingToken: Codable, Sendable {
        public var token: String
        
        public init(token: String) {
            self.token = token
        }
    }
}

public extension Auth.Responses {

    struct SuccessAuth: Codable, Sendable {
        public let accessToken: Token
        public let refreshToken: Token
        public let user: Auth.Internal.UserInfo
        
        public init(accessToken: Token, refreshToken: Token, user: Auth.Internal.UserInfo) {
            self.accessToken = accessToken
            self.refreshToken = refreshToken
            self.user = user
        }
    }
    
    struct Refresh: Codable, Sendable {
        public let accessToken: Token
        public let refreshToken: Token?
        
        public init(accessToken: Token, refreshToken: Token? = nil) {
            self.accessToken = accessToken
            self.refreshToken = refreshToken
        }
    }
}

public extension Auth.Internal {
    
    struct UserInfo: Codable, Sendable {
        public let id: UUID
        public let avatar: URL?
        public let nickname: String?
        public let haveContact: Bool
        public let haveCustomer: Bool
        public let haveEmployee: Bool
        
        public init(
            id: UUID,
            avatar: URL? = nil,
            nickname: String? = nil,
            haveContact: Bool,
            haveCustomer: Bool,
            haveEmployee: Bool
        ) {
            self.id = id
            self.avatar = avatar
            self.nickname = nickname
            self.haveContact = haveContact
            self.haveCustomer = haveCustomer
            self.haveEmployee = haveEmployee
        }
    }
}

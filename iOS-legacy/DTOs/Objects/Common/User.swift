import Foundation

public enum User {
    public enum Parameters {}
    public enum Responses {}
}

public extension User.Parameters {
    
    struct Patch: Codable, Sendable {
        public var nickname: String?
        public var avatar: URL?
        
        public init(nickname: String? = nil, avatar: URL? = nil) {
            self.nickname = nickname
            self.avatar = avatar
        }
    }
}

public extension User.Responses {
    
    struct UserInfo: Codable, Sendable {
        public var id: UUID
        public var avatar: URL
        public var nickname: String
        public let haveCustomer: Bool
        public let haveEmployee: Bool
        
        public init(id: UUID, avatar: URL, nickname: String, haveCustomer: Bool, haveEmployee: Bool) {
            self.id = id
            self.avatar = avatar
            self.nickname = nickname
            self.haveCustomer = haveCustomer
            self.haveEmployee = haveEmployee
        }
    }
}

import Foundation

/// Namespace для всех DTOs относящихся к User
public enum User {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension User.Parameters {
    
    struct Create: Codable {
        var nickname: String
        var email: String?
        var phone: String?
        var avatar: String
    }
    
    struct Patch: Codable {
        var nickname: String?
        var avatar: String?
    }
}

//MARK: - Responses -

public extension User.Responses {
    
    struct Full: Codable {
        public var id: UUID?
        public var avatar: String?
        public var nickname: String?
        public var email: String?
        public var phone: String?
        public var isProfileComplete: Bool
    }
    
    struct Partial: Codable {
        public var id: UUID?
        public var name: String
        public var contacts: [Contact.Responses.Full]
    }
}

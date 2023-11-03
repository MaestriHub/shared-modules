import Foundation

/// Namespace для всех DTOs относящихся к Auth
public enum Auth {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Auth.Parameters {
    
    struct AppleToken: Parametable {
        public let token: String
        
        public let firstName: String?
        public let lastName: String?
        
        public var email: String?
        public var emailVerified: Bool? = false
        
        public var phone: String?
        public var phoneVerified: Bool? = false
    }
    
    struct GoogleToken: Parametable {

        public let token: String
        
        public let firstName: String?
        public let lastName: String?
    }
}

//MARK: - Responses -

public extension Auth.Responses {
    
    struct Full: Responsable {
        public let token: String
        public let user: User.Responses.Full
    }
    
    struct Partial: Responsable {
        public let token: String
    }
}

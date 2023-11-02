import Foundation

/// Namespace для всех DTOs относящихся к Auth
public enum Auth {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Auth.Parameters {
    
    struct AppleToken: Codable {
        let token: String
        
        let firstName: String?
        let lastName: String?
        
        var email: String?
        var emailVerified: Bool? = false
        
        var phone: String?
        var phoneVerified: Bool? = false
    }
    
    struct GoogleToken: Codable {

        let token: String
        
        let firstName: String?
        let lastName: String?
    }
}

//MARK: - Responses -

public extension Auth.Responses {
    
    struct Session: Codable {
        public let token: String
        public let user: User.Responses.Full
    }
}

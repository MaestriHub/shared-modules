import Foundation

/// Namespace для всех DTOs относящихся к Contact
public enum Contact {
    public enum Parameters {}
    public enum Responses {}
    
    
}

public enum ContactType: String, Codable {
    case phone = "phone"
    case email = "email"
    case telegram = "telegram"
    case whatsapp = "whatsapp"
    case instagram = "instagram"
}

//MARK: - Parameters -

public extension Contact.Parameters {
    
    struct Create: Parametable {
        public var value: String
        public var type: ContactType
    }
    
    struct Verify: Codable {
        public var value: String
    }
}

//MARK: - Responses -

public extension Contact.Responses {
    
    struct Full: Responsable {
        public var id: UUID?
        public var value: String
        public var isVerify: Bool
        public var type: ContactType
    }
}

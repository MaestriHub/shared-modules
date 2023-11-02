import Foundation

/// Namespace для всех DTOs относящихся к Contact
public enum Contact {
    public enum Parameters {}
    public enum Responses {}
    
    public enum `Type`: String, Codable, CaseIterable {
        case phone
        case email
        case telegram
        case whatsapp
        case instagram
    }
}

//MARK: - Parameters -

public extension Contact.Parameters {
    
    struct Create: Codable {
        public var value: String
        public var type: Contact.Type
    }
    
    struct Verify: Codable {
        public var value: String
    }
}

//MARK: - Responses -

public extension Contact.Responses {
    
    struct Full: Codable {
        public var id: UUID?
        public var value: String
        public var isVerify: Bool
        public var type: Contact.Type
    }
}

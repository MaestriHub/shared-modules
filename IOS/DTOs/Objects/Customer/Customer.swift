import Foundation

public enum Customer {
    public enum Parameters {}
    public enum Responses {}
    
    public enum Internal {}
}

public extension Customer.Parameters {
    
    struct Registration: Codable, Sendable {
        public var contact: Customer.Internal.Contact?
        
        public init(contact: Customer.Internal.Contact? = nil) {
            self.contact = contact
        }
    }
}

public extension Customer.Responses {
    
    struct Registration: Codable, Sendable {
        public var accessToken: Token
        
        public init(accessToken: Token) {
            self.accessToken = accessToken
        }
    }
}

public extension Customer.Internal {
    struct Contact: Codable, Sendable {
        public var value: String
        public var type: ContactType
        
        public init(value: String, type: ContactType) {
            self.value = value
            self.type = type
        }
    }
}

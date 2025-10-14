import Foundation
import MemberwiseInit

public enum Customer {
    public enum Parameters {}
    public enum Responses {}
    
    public enum Internal {}
}

public extension Customer.Parameters {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Registration: Codable, Sendable {
        public var contact: Customer.Internal.Contact?
    }
}

public extension Customer.Responses {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Registration: Codable, Sendable {
        public var accessToken: Token
    }
}

public extension Customer.Internal {
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Contact: Codable, Sendable {
        public var value: String
        public var type: ContactType
    }
}

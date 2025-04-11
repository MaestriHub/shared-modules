import Foundation
import MemberwiseInit

public enum Customer {
    public enum Parameters {}
    public enum Responses {}
    
    public enum Internal {}
}

public extension Customer.Parameters {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Registration: Parametable {
        public var contact: Customer.Internal.Contact?
    }
}

public extension Customer.Responses {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Registration: Responsable {
        public var accessToken: String
    }
}

public extension Customer.Internal {
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Contact: Codable {
        public var value: String
        public var type: ContactType
    }
}

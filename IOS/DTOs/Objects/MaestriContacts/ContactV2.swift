import Foundation
import MemberwiseInit

public enum ContactV2 {
    public enum Parameters {}
    public enum Responses {}
    public enum Helpers {}
}

public extension ContactV2.Parameters {
    
    // верификации пока нет потому что не понятно как она будет выглядеть
    @MemberwiseInit(.public)
    struct Create: Parametable {
        public let value: String
        public let type: ContactType
    }
}

// MARK: - Responses -

public extension ContactV2.Responses {
    
    @MemberwiseInit(.public)
    struct CreateContact: Responsable {
        public var id: UUID
        public var value: String
        public var type: ContactType
    }
    
    @MemberwiseInit(.public)
    struct GetUserContacts: Responsable {
        public var contacts: [ContactV2.Helpers.UserContact]
    }
    
    @MemberwiseInit(.public)
    struct GetActiveContacts: Responsable {
        public var contacts: [ContactV2.Helpers.ActiveContact]
    }
    
    @MemberwiseInit(.public)
    struct UpdateActiveContact: Responsable {
        public var id: UUID
        public var setPhoneTypes: [PhoneTypes]?
    }
}

public extension ContactV2.Helpers {
    
    @MemberwiseInit(.public)
    struct UserContact: Responsable {
        public var id: UUID
        public var value: String
        public var type: ContactType
    }
    
    @MemberwiseInit(.public)
    struct ActiveContact: Responsable {
        public var id: UUID
        public var value: String
        public var type: ContactType
    }
}

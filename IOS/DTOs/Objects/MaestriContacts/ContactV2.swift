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
    
    @MemberwiseInit(.public)
    struct UpdateActiveContact: Parametable {
        public var setPhoneTypes: [PhoneTypes]?
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
    struct GetRecoveryContacts: Responsable {
        public var contacts: [ContactV2.Helpers.RecoveryContact]
    }
    
    @MemberwiseInit(.public)
    struct GetContacts: Responsable {
        public var contacts: [ContactV2.Helpers.Contact]
    }
    
    @MemberwiseInit(.public)
    struct UpdateContact: Responsable {
        public var id: UUID
        public var value: String
        public var type: ContactType
        public var phonePreference: Set<PhoneTypes>
    }
}

public extension ContactV2.Helpers {
    
    @MemberwiseInit(.public)
    struct RecoveryContact: Responsable {
        public var id: UUID
        public var value: String
        public var type: ContactType
    }
    
    @MemberwiseInit(.public)
    struct Contact: Responsable {
        public var id: UUID
        public var value: String
        public var type: ContactType
        public var phonePreference: Set<PhoneTypes>
    }
}

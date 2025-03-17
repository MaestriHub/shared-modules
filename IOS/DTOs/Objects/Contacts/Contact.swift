import Foundation
import MemberwiseInit

public enum Contact {
    public enum Parameters {}
    public enum Responses {}
    public enum Shared {}
}

public extension Contact.Parameters {
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct CreateRecovery: Parametable {
        public let value: String
        public let type: ContactType
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct CreatePrimary: Parametable {
        public let value: String
        public let type: ContactType
        public let phoneTypes: Set<PhoneTypes>?
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct UpdateContact: Parametable {
        public var phoneTypes: Set<PhoneTypes>?
    }
}

public extension Contact.Responses {
    typealias Create = Contact.Shared.RecoveryContact
    
    typealias RecoveryContacts = [Contact.Shared.RecoveryContact]
    
    typealias PrimaryContacts  = [Contact.Shared.PrimaryContact]
    
    typealias UpdatePrimaryContact = Contact.Shared.PrimaryContact
}

public extension Contact.Shared {
    typealias ContactId = UUID

    // MARK: контакты используемые для восстановления
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct RecoveryContact: Codable {
        public let id: ContactId
        public let value: String
        public let type: ContactType
    }


    // MARK: контакты используемые для отображения
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct PrimaryContact: Codable {
        public let id: ContactId
        public let value: String
        public let type: ContactType
        public let phoneTypes: Set<PhoneTypes>?
    }
}

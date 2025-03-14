import Foundation
import MemberwiseInit

public enum Contact {
    public enum Parameters {}
    public enum Responses {}
    public enum Shared {}
}

public extension Contact.Parameters {
    @MemberwiseInit(.public)
    struct Create: Parametable {
        public let value: String
        public let type: ContactType
    }
    
    @MemberwiseInit(.public)
    struct UpdateContact: Parametable {
        public var setPhoneTypes: Set<PhoneTypes>?
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
    @MemberwiseInit(.public)
    struct RecoveryContact: Codable {
        public let id: ContactId
        public let value: String
        public let type: ContactType
    }


    // MARK: контакты используемые для отображения
    @MemberwiseInit(.public)
    struct PrimaryContact: Codable {
        public let id: ContactId
        public let value: String
        public let type: ContactType
        public var setPhoneTypes: Set<PhoneTypes>?
    }
}

import Foundation

public enum Contact {
    public enum Parameters {}
    public enum Responses {}
    public enum Shared {}
}

public extension Contact.Parameters {
    struct CreateRecovery: Codable, Sendable {
        public let value: String
        public let type: ContactType
        
        public init(value: String, type: ContactType) {
            self.value = value
            self.type = type
        }
    }
    
    struct CreatePrimary: Codable, Sendable {
        public let value: String
        public let type: ContactType
        public let phoneTypes: Set<PhoneTypes>?
        
        public init(value: String, type: ContactType, phoneTypes: Set<PhoneTypes>? = nil) {
            self.value = value
            self.type = type
            self.phoneTypes = phoneTypes
        }
    }
    
    struct UpdateContact: Codable, Sendable {
        public var phoneTypes: Set<PhoneTypes>?
        
        public init(phoneTypes: Set<PhoneTypes>? = nil) {
            self.phoneTypes = phoneTypes
        }
    }
}

public extension Contact.Responses {
    typealias CreateRecovery = Contact.Shared.RecoveryContact
    
    typealias RecoveryContacts = [Contact.Shared.RecoveryContact]
    
    typealias CreatePrimary = Contact.Shared.PrimaryContact
    
    typealias PrimaryContacts  = [Contact.Shared.PrimaryContact]
    
    typealias UpdatePrimaryContact = Contact.Shared.PrimaryContact
}

public extension Contact.Shared {
    typealias ContactId = UUID

    // MARK: контакты используемые для восстановления
    struct RecoveryContact: Codable, Sendable {
        public let id: ContactId
        public let value: String
        public let type: ContactType
        
        public init(id: ContactId, value: String, type: ContactType) {
            self.id = id
            self.value = value
            self.type = type
        }
    }

    // MARK: контакты используемые для отображения
    struct PrimaryContact: Codable, Sendable {
        public let id: ContactId
        public let value: String
        public let type: ContactType
        public let phoneTypes: Set<PhoneTypes>?
        
        public init(id: ContactId, value: String, type: ContactType, phoneTypes: Set<PhoneTypes>? = nil) {
            self.id = id
            self.value = value
            self.type = type
            self.phoneTypes = phoneTypes
        }
    }
}

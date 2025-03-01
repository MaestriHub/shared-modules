import Foundation

public enum ContactV2 {
    public enum Parameters {}
    public enum Responses {}
    public enum Helpers {}
}

public extension ContactV2.Parameters {
    
    // верификации пока нет потому что не понятно как она будет выглядеть
    struct Create: Parametable {
        public let value: String
        public let type: ContactType
        
        public init(
            value: String,
            type: ContactType
        ) {
            self.value = value
            self.type = type
        }
    }
    
    struct Get: Parametable {
        public let requester: ContactV2.Helpers.ContactConsumer
    }
}

// MARK: - Responses -

public extension ContactV2.Responses {

    struct Contact: Responsable {
        public var id: UUID
        public var value: String
        public var type: ContactType
        
        public init(
            id: UUID,
            value: String,
            type: ContactType
        ) {
            self.id = id
            self.value = value
            self.type = type
        }
    }
    
    struct All: Responsable {
        public let allContacts: [Contact]
    }
}

public extension ContactV2.Helpers {
    enum ContactConsumer: Codable {
        case user(UUID)
        case salon(UUID)
        case customer(UUID)
        case employee(UUID)
    }
}

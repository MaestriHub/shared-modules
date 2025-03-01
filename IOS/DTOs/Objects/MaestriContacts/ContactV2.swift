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
    struct Get: Parametable {
        public let requester: ContactV2.Helpers.ContactConsumer
    }
}

// MARK: - Responses -

public extension ContactV2.Responses {

    @MemberwiseInit(.public)
    struct Contact: Responsable {
        public var id: UUID
        public var value: String
        public var type: ContactType
    }
    
    @MemberwiseInit(.public)
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

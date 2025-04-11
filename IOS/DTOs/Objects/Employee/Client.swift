import Foundation
import MemberwiseInit

public enum Client {
    public enum Parameters {}
    public enum Responses {}
    
    public enum Internal {}
}

public extension Client.Parameters {
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Create: Parametable {
        public var alias: String
        public var contact: Client.Internal.Contact?
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Retrieve: Parametable {
        public let employees: [UUID]?
    }
}

public extension Client.Responses {
    typealias Clients = [ClientInfo]
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct ClientInfo: Responsable {
        public var id: UUID
        public var user: Client.Internal.ClientUserOneOf
        public var alias: String?
        public var contacts: [Contact.Shared.PrimaryContact]
    }

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Verify: Responsable {
        public var contacts: [Contact.Shared.PrimaryContact]
    }
}

public extension Client.Internal {
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Contact: Codable {
        public var value: String
        public var type: ContactType
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct ClientUserOneOf: Codable {
        public let link: URL?
        public let value: UserInfo?
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct UserInfo: Codable {
        public var avatar: URL?
        public var nickname: String
    }
}

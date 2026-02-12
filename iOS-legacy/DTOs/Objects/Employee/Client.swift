import Foundation

public enum Client {
    public enum Parameters {}
    public enum Responses {}
    
    public enum Internal {}
}

public extension Client.Parameters {
    struct Create: Codable, Sendable {
        public var alias: String
        public var contact: Client.Internal.Contact?
        
        public init(alias: String, contact: Client.Internal.Contact? = nil) {
            self.alias = alias
            self.contact = contact
        }
    }
    
    struct Retrieve: Codable, Sendable {
        public init() {
        }
    }
    
    struct Update: Codable, Sendable {
        public var alias: String?
        public var contact: Client.Internal.Contact?
        
        public init(alias: String? = nil, contact: Client.Internal.Contact? = nil) {
            self.alias = alias
            self.contact = contact
        }
    }
}

public extension Client.Responses {
    typealias Clients = [ClientInfo]
    
    struct ClientInfo: Codable, Sendable {
        public var id: UUID
        public var name: String
        public var avatar: URL
        public var alias: String?
        public var contacts: [Contact.Shared.PrimaryContact]
        public var inviteLink: URL?
        
        public init(
            id: UUID,
            name: String,
            avatar: URL,
            alias: String? = nil,
            contacts: [Contact.Shared.PrimaryContact],
            inviteLink: URL? = nil
        ) {
            self.id = id
            self.name = name
            self.avatar = avatar
            self.alias = alias
            self.contacts = contacts
            self.inviteLink = inviteLink
        }
    }

    struct Verify: Codable, Sendable {
        public var contacts: [Contact.Shared.PrimaryContact]
        
        public init(contacts: [Contact.Shared.PrimaryContact]) {
            self.contacts = contacts
        }
    }
}

public extension Client.Internal {
    struct Contact: Codable, Sendable {
        public var value: String
        public var type: ContactType
        
        public init(value: String, type: ContactType) {
            self.value = value
            self.type = type
        }
    }
    
    struct UserInfo: Codable, Sendable {
        public var avatar: URL
        public var nickname: String
        
        public init(avatar: URL, nickname: String) {
            self.avatar = avatar
            self.nickname = nickname
        }
    }
}

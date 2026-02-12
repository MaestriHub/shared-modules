import Foundation

public enum HandleInvite {
    public enum Parameters {}
    public enum Responses {}
    public enum Internal {}
}

public extension HandleInvite.Parameters {
  
    struct ClientMerge: Codable, Sendable {
        public var contact: String
        
        public init(contact: String) {
            self.contact = contact
        }
    }
}

public extension HandleInvite.Responses {
    
    struct EmployeeSuccess: Codable, Sendable {
        public let id: UUID
        public let nickname: String
        public let logo: URL
        public let position: String
        
        public init(id: UUID, nickname: String, logo: URL, position: String) {
            self.id = id
            self.nickname = nickname
            self.logo = logo
            self.position = position
        }
    }
    
    struct MaskedContacts: Codable, Sendable {
        public let contacts: [String]
        
        public init(contacts: [String]) {
            self.contacts = contacts
        }
    }
    
    struct ClientMergeSuccess: Codable, Sendable {
        public let id: UUID
        public let alias: String?
        
        public init(id: UUID, alias: String? = nil) {
            self.id = id
            self.alias = alias
        }
    }
}

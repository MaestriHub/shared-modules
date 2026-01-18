import Foundation

public enum Position {
    public enum Parameters {}
    public enum Responses {}
}

public extension Position.Parameters {
    
    struct Create: Codable, Sendable {
        public var title: String
        public var creds: CredentialsSet
        public var makeOwner: Bool
        // public var salary: Salary.Parameters.Rules.Create
        
        public init(title: String, creds: CredentialsSet, makeOwner: Bool) {
            self.title = title
            self.creds = creds  
            self.makeOwner = makeOwner
        }
    }

    struct Patch: Codable, Sendable {
        public var title: String?
        public var creds: CredentialsSet?
        public var makeOwner: Bool?
        // public var salary: Salary.Parameters.Rules.Create?
        
        public init(
            title: String? = nil,
            creds: CredentialsSet? = nil,
            makeOwner: Bool? = nil
        ) {
            self.title = title
            self.creds = creds
            self.makeOwner = makeOwner
        }
    }
}

public extension Position.Responses {
    
    struct Full: Codable, Sendable {
        public var id: UUID
        public var title: String
        public var creds: CredentialsSet
        public var owner: Bool
        
        public init(id: UUID, title: String, creds: CredentialsSet, owner: Bool) {
            self.id = id
            self.title = title
            self.creds = creds
            self.owner = owner
        }
    }

    struct Partial: Codable, Sendable {
        public var id: UUID
        public var title: String
        
        public init(id: UUID, title: String) {
            self.id = id
            self.title = title
        }
    }
}

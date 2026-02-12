import Foundation

public enum Workspace {
    public enum Parameters {}
    public enum Responses {}
    
    public enum Internal {}
}

public extension Workspace.Parameters {
 
    struct Create: Codable, Sendable {
        public let name: String
        public let type: SalonType
        public let logo: URL?
        public let timeZoneId: String
        public let localeId: String
        public let description: String?
        public let timetable: Timetable.Parameters.Create.Pattern?
        public let contact: Workspace.Internal.Contact?
        public let address: Address
        
        public init(
            name: String,
            type: SalonType,
            logo: URL? = nil,
            timeZoneId: String,
            localeId: String,
            description: String? = nil,
            timetable: Timetable.Parameters.Create.Pattern? = nil,
            contact: Workspace.Internal.Contact? = nil,
            address: Address
        ) {
            self.name = name
            self.type = type
            self.logo = logo
            self.timeZoneId = timeZoneId
            self.localeId = localeId
            self.description = description
            self.timetable = timetable
            self.contact = contact
            self.address = address
        }
    }

    struct Patch: Codable, Sendable {
        public let name: String?
        public let type: SalonType?
        public let description: String?
        public let logo: URL?
        public let address: Address?
        
        public init(
            name: String? = nil,
            type: SalonType? = nil,
            description: String? = nil,
            logo: URL? = nil,
            address: Address? = nil
        ) {
            self.name = name
            self.type = type
            self.description = description
            self.logo = logo
            self.address = address
        }
    }
}

public extension Workspace.Responses {
    
    struct Full: Codable, Sendable {
        public var id: UUID
        public var name: String
        public var type: SalonType
        public var description: String?
        public var logo: URL
        public var address: Address
        public var isActive: Bool
        public var localeId: String
        public var timeZoneId: String
        public var employeeToken: Token
        public var inviteLink: URL?
        public var createdAt: Date
        
        public init(
            id: UUID,
            name: String,
            type: SalonType,
            description: String? = nil,
            logo: URL,
            address: Address,
            isActive: Bool,
            localeId: String,
            timeZoneId: String,
            employeeToken: Token,
            inviteLink: URL?,
            createdAt: Date
        ) {
            self.id = id
            self.name = name
            self.type = type
            self.description = description
            self.logo = logo
            self.address = address
            self.isActive = isActive
            self.localeId = localeId
            self.timeZoneId = timeZoneId
            self.employeeToken = employeeToken
            self.inviteLink = inviteLink
            self.createdAt = createdAt
        }
    }
    
    struct Partial: Codable, Sendable {
        public var id: UUID
        public var name: String
        public var type: SalonType
        public var logo: URL
        public var address: Address
        public var inviteLink: URL?
        
        public init(
            id: UUID,
            name: String,
            type: SalonType,
            logo: URL,
            address: Address,
            inviteLink: URL?
        ) {
            self.id = id
            self.name = name
            self.type = type
            self.logo = logo
            self.address = address
            self.inviteLink = inviteLink
        }
    }
}

public extension Workspace.Internal {
    struct Contact: Codable, Sendable {
        public var value: String
        public var type: ContactType
        
        public init(value: String, type: ContactType) {
            self.value = value
            self.type = type
        }
    }
}

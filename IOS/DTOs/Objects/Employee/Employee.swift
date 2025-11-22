import Foundation

public enum Employee {
    public enum Parameters {}
    public enum Responses {}
    
    public enum Internal {}
}

public extension Employee.Parameters {
    
    struct Invite: Codable, Sendable {
        public var nickname: String?
        public var salonId: UUID
        public var positionId: UUID
        public var contact: Employee.Internal.Contact?
        public var timetable: Timetable.Parameters.Create.Pattern?
        
        public init(
            nickname: String? = nil,
            salonId: UUID,
            positionId: UUID,
            contact: Employee.Internal.Contact? = nil,
            timetable: Timetable.Parameters.Create.Pattern? = nil
        ) {
            self.nickname = nickname
            self.salonId = salonId
            self.positionId = positionId
            self.contact = contact
            self.timetable = timetable
        }
    }
    
    struct Patch: Codable, Sendable {
        public var positionId: UUID?
        
        public init(positionId: UUID? = nil) {
            self.positionId = positionId
        }
    }
}

public extension Employee.Responses {

    struct Full: Codable, Sendable {
        public var id: UUID
        public var user: Employee.Internal.UserInfo?
        public var contacts: [Contact.Shared.PrimaryContact]
        public var salonId: UUID
        public var position: Position.Responses.Full
        public var inviteLink: URL?
        
        public init(
            id: UUID,
            user: Employee.Internal.UserInfo? = nil,
            contacts: [Contact.Shared.PrimaryContact],
            salonId: UUID,
            position: Position.Responses.Full,
            inviteLink: URL? = nil
        ) {
            self.id = id
            self.user = user
            self.contacts = contacts
            self.salonId = salonId
            self.position = position
            self.inviteLink = inviteLink
        }
    }
    
    struct Partial: Codable, Sendable {
        public var id: UUID
        public var nickname: String
        public var avatar: URL
        public var contacts: [Contact.Shared.PrimaryContact]
        public var position: Position.Responses.Partial
        public var inviteLink: URL?
        
        public init(
            id: UUID,
            nickname: String,
            avatar: URL,
            contacts: [Contact.Shared.PrimaryContact],
            position: Position.Responses.Partial,
            inviteLink: URL? = nil
        ) {
            self.id = id
            self.nickname = nickname
            self.avatar = avatar
            self.contacts = contacts
            self.position = position
            self.inviteLink = inviteLink
        }
    }
}

public extension Employee.Internal {
    struct Contact: Codable, Sendable {
        public var value: String
        public var type: ContactType
        
        public init(value: String, type: ContactType) {
            self.value = value
            self.type = type
        }
    }
    
    struct UserInfo: Codable, Sendable {
        public var id: UUID
        public var nickname: String
        public var avatar: URL
        
        public init(id: UUID, nickname: String, avatar: URL) {
            self.id = id
            self.nickname = nickname
            self.avatar = avatar
        }
    }
}

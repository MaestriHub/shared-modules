import Foundation

public enum Salon {
    public enum Responses {}
}

public extension Salon.Responses {
    
    struct Full: Codable, Sendable {
        public let id: UUID
        public let name: String
        public let type: SalonType
        public let description: String?
        public let logo: URL
        public let isActive: Bool
        public let isFavorite: Bool
        public let localeId: String
        public let timeZoneId: String
        public let address: Address
        public let inviteLink: URL?
        
        public init(
            id: UUID,
            name: String,
            type: SalonType,
            description: String? = nil,
            logo: URL,
            isActive: Bool,
            isFavorite: Bool = false,
            localeId: String,
            timeZoneId: String,
            address: Address,
            inviteLink: URL?
        ) {
            self.id = id
            self.name = name
            self.type = type
            self.description = description
            self.logo = logo
            self.isActive = isActive
            self.isFavorite = isFavorite
            self.localeId = localeId
            self.timeZoneId = timeZoneId
            self.address = address
            self.inviteLink = inviteLink
        }
    }
}

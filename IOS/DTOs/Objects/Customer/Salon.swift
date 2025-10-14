import Foundation

public enum Salon {
    public enum Responses {}
}

public extension Salon.Responses {
    
    struct Full: Codable, Sendable {
        public var id: UUID
        public var name: String
        public var type: SalonType
        public var description: String?
        public var logo: URL
        public var isActive: Bool
        public var isFavorite: Bool = false
        public var localeId: String
        public var timeZoneId: String
        public var address: Address
        public var point: CoordinatePoint
        
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
            point: CoordinatePoint
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
            self.point = point
        }
    }
}

import Foundation

public enum Favorite {
    public enum Responses {}
}

public extension Favorite.Responses {
    typealias Salons = [Salon]
    
    struct Salon: Codable, Sendable {
        public var id: UUID
        public var name: String
        public var type: SalonType
        public var logo: URL
        public var isActive: Bool
        public var address: Address
        public var point: CoordinatePoint
        
        public init(
            id: UUID,
            name: String,
            type: SalonType,
            logo: URL,
            isActive: Bool,
            address: Address,
            point: CoordinatePoint
        ) {
            self.id = id
            self.name = name
            self.type = type
            self.logo = logo
            self.isActive = isActive
            self.address = address
            self.point = point
        }
    }
}

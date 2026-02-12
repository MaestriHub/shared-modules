import Foundation

public enum Favorite {
    public enum Responses {}
}

public extension Favorite.Responses {
    typealias Salons = [Salon]
    
    struct Salon: Codable, Sendable {
        public let id: UUID
        public let name: String
        public let type: SalonType
        public let logo: URL
        public let isActive: Bool
        public let address: Address
        
        public init(
            id: UUID,
            name: String,
            type: SalonType,
            logo: URL,
            isActive: Bool,
            address: Address
        ) {
            self.id = id
            self.name = name
            self.type = type
            self.logo = logo
            self.isActive = isActive
            self.address = address
        }
    }
}

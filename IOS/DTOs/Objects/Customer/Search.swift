import Foundation

public enum Search {
    public enum Parameters {}
    public enum Responses {
        public enum Helpers {}
    }
}

public extension Search.Parameters {
    
    struct Retrieve: Codable, Sendable {
        public let value: String?
        public let salonType: SalonType?
        public let latitude: Double?
        public let longitude: Double?
        public let pagination: Pagination?
        
        public init(
            value: String? = nil,
            salonType: SalonType? = nil,
            latitude: Double? = nil,
            longitude: Double? = nil,
            pagination: Pagination? = nil
        ) {
            self.value = value
            self.salonType = salonType
            self.latitude = latitude
            self.longitude = longitude
            self.pagination = pagination
        }
    }
}

public extension Search.Responses {

    struct Full: Codable, Sendable {
        public var suggests: [Helpers.Suggest]
        public var salons: [Helpers.Salon]
        
        public init(suggests: [Helpers.Suggest], salons: [Helpers.Salon]) {
            self.suggests = suggests
            self.salons = salons
        }
    }
}

public extension Search.Responses.Helpers {
    
    struct Suggest: Codable, Sendable {
        public var value: String
        
        public init(value: String) {
            self.value = value
        }
    }
    
    struct Salon: Codable, Sendable {
        public let id: UUID
        public let name: String
        public let type: SalonType
        public let logo: URL
        public let isFavorite: Bool
        public let address: Address
        
        public init(
            id: UUID,
            name: String,
            type: SalonType,
            logo: URL,
            isFavorite: Bool = false,
            address: Address
        ) {
            self.id = id
            self.name = name
            self.type = type
            self.logo = logo
            self.isFavorite = isFavorite
            self.address = address
        }
    }
}

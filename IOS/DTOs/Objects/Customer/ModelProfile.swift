import Foundation

public enum ModelProfile {
    public enum Parameters {}
    public enum Responses {}
}

public extension ModelProfile.Parameters {
    
    struct Create: Codable, Sendable {
        public let address: Address
        public let radiusMeters: Int
        public let availabilityDaysMask: AvailabilityDaysMask?
        public let availabilityTimesMask: AvailabilityTimesMask?
        public let availabilityTagsMask: AvailabilityTagsMask?
        public let restrictionsMask: RestrictionsMask?
        public let favoritesOnly: Bool
        public let allowPhotoVideo: Bool
        
        public init(
            address: Address,
            radiusMeters: Int,
            availabilityDaysMask: AvailabilityDaysMask? = nil,
            availabilityTimesMask: AvailabilityTimesMask? = nil,
            availabilityTagsMask: AvailabilityTagsMask? = nil,
            restrictionsMask: RestrictionsMask? = nil,
            favoritesOnly: Bool,
            allowPhotoVideo: Bool
        ) {
            self.address = address
            self.radiusMeters = radiusMeters
            self.availabilityDaysMask = availabilityDaysMask
            self.availabilityTimesMask = availabilityTimesMask
            self.availabilityTagsMask = availabilityTagsMask
            self.restrictionsMask = restrictionsMask
            self.favoritesOnly = favoritesOnly
            self.allowPhotoVideo = allowPhotoVideo
        }
    }
    
    struct Update: Codable, Sendable {
        public let status: ModelProfileStatus?
        public let address: Address?
        public let radiusMeters: Int?
        public let availabilityDaysMask: AvailabilityDaysMask?
        public let availabilityTimesMask: AvailabilityTimesMask?
        public let availabilityTagsMask: AvailabilityTagsMask?
        public let restrictionsMask: RestrictionsMask?
        public let favoritesOnly: Bool?
        public let allowPhotoVideo: Bool?
        
        public init(
            status: ModelProfileStatus? = nil,
            address: Address? = nil,
            radiusMeters: Int? = nil,
            availabilityDaysMask: AvailabilityDaysMask? = nil,
            availabilityTimesMask: AvailabilityTimesMask? = nil,
            availabilityTagsMask: AvailabilityTagsMask? = nil,
            restrictionsMask: RestrictionsMask? = nil,
            favoritesOnly: Bool? = nil,
            allowPhotoVideo: Bool? = nil
        ) {
            self.status = status
            self.address = address
            self.radiusMeters = radiusMeters
            self.availabilityDaysMask = availabilityDaysMask
            self.availabilityTimesMask = availabilityTimesMask
            self.availabilityTagsMask = availabilityTagsMask
            self.restrictionsMask = restrictionsMask
            self.favoritesOnly = favoritesOnly
            self.allowPhotoVideo = allowPhotoVideo
        }
    }
}

public extension ModelProfile.Responses {
    
    struct Full: Codable, Sendable {
        public let id: UUID
        public let customerId: UUID
        public let status: ModelProfileStatus
        public let address: Address
        public let radiusMeters: Int
        public let availabilityDaysMask: AvailabilityDaysMask
        public let availabilityTimesMask: AvailabilityTimesMask
        public let availabilityTagsMask: AvailabilityTagsMask?
        public let restrictionsMask: RestrictionsMask
        public let favoritesOnly: Bool
        public let allowPhotoVideo: Bool
        public let createdAt: Date?
        public let updatedAt: Date?
        
        public init(
            id: UUID,
            customerId: UUID,
            status: ModelProfileStatus,
            address: Address,
            radiusMeters: Int,
            availabilityDaysMask: AvailabilityDaysMask,
            availabilityTimesMask: AvailabilityTimesMask,
            availabilityTagsMask: AvailabilityTagsMask? = nil,
            restrictionsMask: RestrictionsMask,
            favoritesOnly: Bool,
            allowPhotoVideo: Bool,
            createdAt: Date? = nil,
            updatedAt: Date? = nil
        ) {
            self.id = id
            self.customerId = customerId
            self.status = status
            self.address = address
            self.radiusMeters = radiusMeters
            self.availabilityDaysMask = availabilityDaysMask
            self.availabilityTimesMask = availabilityTimesMask
            self.availabilityTagsMask = availabilityTagsMask
            self.restrictionsMask = restrictionsMask
            self.favoritesOnly = favoritesOnly
            self.allowPhotoVideo = allowPhotoVideo
            self.createdAt = createdAt
            self.updatedAt = updatedAt
        }
    }
}
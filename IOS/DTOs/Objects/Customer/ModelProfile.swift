import Foundation

public enum ModelProfile {
    public enum Parameters {}
    public enum Responses {}
}

public extension ModelProfile.Parameters {
    
    struct Create: Codable, Sendable {
        public let address: Address
        public let radiusMeters: Int
        public let photos: [URL]
        public let gender: Gender?
        public let birthDate: Date
        public let availabilityDaysMask: AvailabilityDaysMask?
        public let availabilityTimesMask: AvailabilityTimesMask?
        public let availabilityTagsMask: AvailabilityTagsMask?
        public let restrictionsMask: RestrictionsMask?
        public let favoritesOnly: Bool
        public let agreeToShootingAndMaterialUsage: Bool
        public let agreeToPlatformRules: Bool
        
        public init(
            address: Address,
            radiusMeters: Int,
            photos: [URL],
            gender: Gender?,
            birthDate: Date,
            availabilityDaysMask: AvailabilityDaysMask? = nil,
            availabilityTimesMask: AvailabilityTimesMask? = nil,
            availabilityTagsMask: AvailabilityTagsMask? = nil,
            restrictionsMask: RestrictionsMask? = nil,
            favoritesOnly: Bool,
            agreeToShootingAndMaterialUsage: Bool,
            agreeToPlatformRules: Bool
        ) {
            self.address = address
            self.radiusMeters = radiusMeters
            self.photos = photos
            self.gender = gender
            self.birthDate = birthDate
            self.availabilityDaysMask = availabilityDaysMask
            self.availabilityTimesMask = availabilityTimesMask
            self.availabilityTagsMask = availabilityTagsMask
            self.restrictionsMask = restrictionsMask
            self.favoritesOnly = favoritesOnly
            self.agreeToShootingAndMaterialUsage = agreeToShootingAndMaterialUsage
            self.agreeToPlatformRules = agreeToPlatformRules
        }
    }
    
    struct Update: Codable, Sendable {
        public let status: ModelProfileStatus?
        public let address: Address?
        public let radiusMeters: Int?
        public let photos: [URL]?
        public let gender: Gender?
        public let birthDate: Date?
        public let availabilityDaysMask: AvailabilityDaysMask?
        public let availabilityTimesMask: AvailabilityTimesMask?
        public let availabilityTagsMask: AvailabilityTagsMask?
        public let restrictionsMask: RestrictionsMask?
        public let favoritesOnly: Bool?
        public let agreeToShootingAndMaterialUsage: Bool?
        public let agreeToPlatformRules: Bool?

        public init(
            status: ModelProfileStatus? = nil,
            address: Address? = nil,
            radiusMeters: Int? = nil,
            photos: [URL]? = nil,
            gender: Gender? = nil,
            birthDate: Date? = nil,
            availabilityDaysMask: AvailabilityDaysMask? = nil,
            availabilityTimesMask: AvailabilityTimesMask? = nil,
            availabilityTagsMask: AvailabilityTagsMask? = nil,
            restrictionsMask: RestrictionsMask? = nil,
            favoritesOnly: Bool? = nil,
            agreeToShootingAndMaterialUsage: Bool? = nil,
            agreeToPlatformRules: Bool? = nil
        ) {
            self.status = status
            self.address = address
            self.radiusMeters = radiusMeters
            self.photos = photos
            self.gender = gender
            self.birthDate = birthDate
            self.availabilityDaysMask = availabilityDaysMask
            self.availabilityTimesMask = availabilityTimesMask
            self.availabilityTagsMask = availabilityTagsMask
            self.restrictionsMask = restrictionsMask
            self.favoritesOnly = favoritesOnly
            self.agreeToShootingAndMaterialUsage = agreeToShootingAndMaterialUsage
            self.agreeToPlatformRules = agreeToPlatformRules
        }
    }
}

public extension ModelProfile.Responses {
    
    struct Full: Codable, Sendable {
        public let id: UUID
        public let customerId: UUID
        public let status: ModelProfileStatus
        public let photos: [URL]
        public let gender: Gender?
        public let birthDate: Date?
        public let address: Address
        public let radiusMeters: Int
        public let availabilityDaysMask: AvailabilityDaysMask
        public let availabilityTimesMask: AvailabilityTimesMask
        public let availabilityTagsMask: AvailabilityTagsMask?
        public let restrictionsMask: RestrictionsMask
        public let favoritesOnly: Bool
        public let agreeToShootingAndMaterialUsage: Bool
        public let agreeToPlatformRules: Bool
        public let createdAt: Date
        public let updatedAt: Date?
        
        public init(
            id: UUID,
            customerId: UUID,
            status: ModelProfileStatus,
            photos: [URL],
            gender: Gender?,
            birthDate: Date?,
            address: Address,
            radiusMeters: Int,
            availabilityDaysMask: AvailabilityDaysMask,
            availabilityTimesMask: AvailabilityTimesMask,
            availabilityTagsMask: AvailabilityTagsMask?,
            restrictionsMask: RestrictionsMask,
            favoritesOnly: Bool,
            agreeToShootingAndMaterialUsage: Bool,
            agreeToPlatformRules: Bool,
            createdAt: Date,
            updatedAt: Date? = nil
        ) {
            self.id = id
            self.customerId = customerId
            self.status = status
            self.photos = photos
            self.gender = gender
            self.birthDate = birthDate
            self.address = address
            self.radiusMeters = radiusMeters
            self.availabilityDaysMask = availabilityDaysMask
            self.availabilityTimesMask = availabilityTimesMask
            self.availabilityTagsMask = availabilityTagsMask
            self.restrictionsMask = restrictionsMask
            self.favoritesOnly = favoritesOnly
            self.agreeToShootingAndMaterialUsage = agreeToShootingAndMaterialUsage
            self.agreeToPlatformRules = agreeToPlatformRules
            self.createdAt = createdAt
            self.updatedAt = updatedAt
        }
    }
}
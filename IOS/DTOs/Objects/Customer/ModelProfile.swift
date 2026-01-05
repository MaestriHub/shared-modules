import Foundation

public enum ModelProfile {
    public enum Parameters {
        public struct Create: Codable {
            public let address: Address
            public let radiusMeters: Int
            public let availabilityDaysMask: AvailabilityDaysMask?
            public let availabilityTimesMask: AvailabilityTimesMask?
            public let availabilityTagsMask: AvailabilityTagsMask?
            public let restrictionsMask: RestrictionsMask?
            public let favoritesOnly: Bool
            public let allowPhotoVideo: Bool
        }
        
        public struct Update: Codable {
            public let status: ModelProfileStatus?
            public let address: Address?
            public let radiusMeters: Int?
            public let availabilityDaysMask: AvailabilityDaysMask?
            public let availabilityTimesMask: AvailabilityTimesMask?
            public let availabilityTagsMask: AvailabilityTagsMask?
            public let restrictionsMask: RestrictionsMask?
            public let favoritesOnly: Bool?
            public let allowPhotoVideo: Bool?
        }
    }
    
    public enum Responses {
        public struct Full: Codable {
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
        }
    }
}
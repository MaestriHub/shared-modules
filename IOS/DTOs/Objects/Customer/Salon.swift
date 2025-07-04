import Foundation
import MemberwiseInit

public enum Salon {
    public enum Responses {}
}

public extension Salon.Responses {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Full: Codable {
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
    }
}

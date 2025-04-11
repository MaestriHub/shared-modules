import Foundation
import MemberwiseInit

public enum Favorite {
    public enum Responses {}
}

public extension Favorite.Responses {
    typealias Salons = [Salon]
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Salon: Responsable {
        public var id: UUID
        public var name: String
        public var type: SalonType
        public var logo: URL?
        public var address: Address
        public var isActive: Bool
    }
}

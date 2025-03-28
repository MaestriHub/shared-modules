import Foundation
import MemberwiseInit

public enum Salon {
    public enum Parameters {}
    public enum Responses {}
}

public extension Salon.Parameters {
 
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Create: Parametable {
        public let name: String
        public let type: SalonType
        public let logo: URL?
        public let timeZoneId: String
        public let localeId: String
        public let description: String?
        public let timetable: Timetable.Parameters.Create.Pattern?
        public let address: Address
        public let contactValue: String
        public let contactType: ContactType
    }

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Patch: Parametable {
        public let name: String?
        public let type: SalonType?
        public let description: String?
        public let logo: URL?
    }
}

public extension Salon.Responses {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Full: Responsable {
        public var id: UUID
        public var name: String
        public var type: SalonType
        public var description: String?
        public var logo: URL?
        public var address: Address
        public var isActive: Bool
        public var canEdit: Bool = false
        public var isFavorite: Bool = false
        public var localeId: String
        public var timeZoneId: String
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Partial: Responsable {
        public var id: UUID
        public var name: String
        public var type: SalonType
        public var logo: URL?
        public var address: Address
        public var isFavorite: Bool = false
    }
}


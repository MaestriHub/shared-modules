import Foundation
import MemberwiseInit

public enum Search {
    public enum Parameters {}
    public enum Responses {}
}

public extension Search.Responses {
    enum Helpers {}
}

public extension Search.Parameters {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Retrieve: Parametable {
        public let value: String?
        public let salonType: SalonType?
        public let latitude: Double?
        public let longitude: Double?
        public let pagination: Pagination?
    }
}

public extension Search.Responses {

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Full: Responsable {
        public var suggests: [Helpers.Suggest]
        public var salons: [Helpers.Salon]
    }
}

public extension Search.Responses.Helpers {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Suggest: Responsable {
        public var value: String
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Salon: Codable {
        public var id: UUID
        public var name: String
        public var type: SalonType
        public var logo: URL?
        public var address: Address
        public var isFavorite: Bool = false
    }
}

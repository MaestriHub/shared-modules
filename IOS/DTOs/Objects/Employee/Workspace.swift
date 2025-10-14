import Foundation
import MemberwiseInit

public enum Workspace {
    public enum Parameters {}
    public enum Responses {}
    
    public enum Internal {}
}

public extension Workspace.Parameters {
 
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Create: Codable, Sendable {
        public let name: String
        public let type: SalonType
        public let logo: URL?
        public let timeZoneId: String
        public let localeId: String
        public let description: String?
        public let timetable: Timetable.Parameters.Create.Pattern?
        public let contact: Workspace.Internal.Contact?
        public let address: Address
        public var point: CoordinatePoint
    }

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Patch: Codable, Sendable {
        public let name: String?
        public let type: SalonType?
        public let description: String?
        public let logo: URL?
    }
}

public extension Workspace.Responses {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Full: Codable, Sendable {
        public var id: UUID
        public var name: String
        public var type: SalonType
        public var description: String?
        public var logo: URL
        public var address: Address
        public var point: CoordinatePoint
        public var isActive: Bool
        public var localeId: String
        public var timeZoneId: String
        public var employeeToken: Token
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Partial: Codable, Sendable {
        public var id: UUID
        public var name: String
        public var type: SalonType
        public var logo: URL
        public var address: Address
        public var point: CoordinatePoint
    }
}

public extension Workspace.Internal {
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Contact: Codable, Sendable {
        public var value: String
        public var type: ContactType
    }
}

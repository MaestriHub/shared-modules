import Foundation

public enum Device {
    public enum Parameters {}
    public enum Responses {}
}

public extension Device.Parameters {

    struct System: Codable, Sendable {
        public var manufacturer : String?
        public var model: String?
        public var system: SystemType?
        public var appVersion: String?
        public var country: String?
        public let fcmToken: String?
        
        public init(
            manufacturer: String? = nil,
            model: String? = nil,
            system: SystemType? = nil,
            appVersion: String? = nil,
            country: String? = nil,
            fcmToken: String? = nil
        ) {
            self.manufacturer = manufacturer
            self.model = model
            self.system = system
            self.appVersion = appVersion
            self.country = country
            self.fcmToken = fcmToken
        }
    }
}

public extension Device.Responses {
    
    struct Full: Codable, Sendable {
        public var id: UUID
        public var version: VersionType?
        
        public init(id: UUID, version: VersionType? = nil) {
            self.id = id
            self.version = version
        }
    }
}

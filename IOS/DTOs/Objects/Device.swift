import Foundation
import MemberwiseInit

public enum Device {
    public enum Parameters {}
    public enum Responses {}
}

public extension Device.Parameters {

    @MemberwiseInit(.public)
    struct System: Parametable {
        public var manufacturer : String?
        public var model: String?
        public var system: SystemType?
        public var appVersion: String?
        public var country: String?
        public let fcmToken: String?
    }
}

public extension Device.Responses {
    
    @MemberwiseInit(.public)
    struct Full: Responsable {
        public var id: UUID
        public var version: VersionType?
    }
}

import Foundation
import MemberwiseInit

extension CustomerAPI {
    public enum Appointment {
        public enum Parameters {
            public enum Create {}
        }
        public enum Responses {}
    }
}

public extension CustomerAPI.Appointment.Parameters.Create {
    @MemberwiseInit(.public)
    struct Procedure: Codable {
        public let procedureId: UUID
        public let time: SafeDateInterval
    }
    
    @MemberwiseInit(.public)
    struct Complex: Codable {
        public let complexId: UUID
        public let chunks: [Chunk]
        
        @MemberwiseInit(.public)
        public struct Chunk: Codable {
            public var id: UUID
            public var procedureId: UUID
            public var time: SafeDateInterval
        }
    }
}

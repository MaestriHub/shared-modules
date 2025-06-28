import Foundation
import MemberwiseInit

extension CustomerAPI {
    public enum Appointment {
        public enum Parameters {
            public enum Create {}
            public enum All {}
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

public extension CustomerAPI.Appointment.Parameters {
    // Reversed.jpeg (maybe paginated in past)
    @MemberwiseInit(.public)
    struct ByPagination: Codable {
        public let startDate: Date
        public var pagination: Pagination
        public let reversed: Bool
    }
}

import Foundation
import MemberwiseInit

extension EmployeeAPI {
    public enum Appointment {
        public enum Parameters {
            public enum Create {}
            public enum All    {}
            public enum Update {}
        }
        
        public enum Responses {}
    }
}

public extension EmployeeAPI.Appointment.Parameters.Create {
    @MemberwiseInit(.public)
    struct Procedure: Codable {
        public let clientId: UUID
        public let procedureId: UUID
        public let time: SafeDateInterval
    }
    
    @MemberwiseInit(.public)
    struct Complex: Codable {
        public let clientId: UUID
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

public extension EmployeeAPI.Appointment.Parameters.All {
    // EndDate.jpeg
    @MemberwiseInit(.public)
    struct ByDates: Codable {
        public let startDate: Date
        public let endDate: Date
        public let clientId: UUID?
    }
    
    // Reversed.jpeg (maybe paginated in past)
    @MemberwiseInit(.public)
    struct ByPagination: Codable {
        public let startDate: Date
        public let clientId: UUID?
        public var pagination: Pagination
        public let reversed: Bool
    }
}

public extension EmployeeAPI.Appointment.Parameters.Update {
    @MemberwiseInit(.public)
    struct Procedure: Codable {
        public let time: SafeDateInterval
    }
}

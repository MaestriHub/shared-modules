import Foundation
import MemberwiseInit

public struct Appointment_NewParameters {
    @MemberwiseInit(.public)
    public struct CreateProcedure: Codable {
        public let procedureId: UUID
        public let time: SafeDateInterval
    }
    
    @MemberwiseInit(.public)
    public struct CreateComplex: Codable {
        public let complexId: UUID
        public let chunks: [Chunk]
        
        @MemberwiseInit(.public)
        public struct Chunk: Codable {
            public var id: UUID
            public var procedureId: UUID
            public var time: SafeDateInterval
        }
    }
    
    // EndDate.jpeg
    @MemberwiseInit(.public)
    public struct AllByDates: Codable {
        public let startDate: Date
        public let endDate: Date
        public let clientId: UUID?
    }
    
    // Reversed.jpeg (maybe paginated in past)
    @MemberwiseInit(.public)
    public struct AllByPagination: Codable {
        public let startDate: Date
        public let clientId: UUID?
        public var pagination: Pagination
        public let reversed: Bool
    }
}

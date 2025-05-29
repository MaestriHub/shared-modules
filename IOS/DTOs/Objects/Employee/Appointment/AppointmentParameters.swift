import Foundation
import MemberwiseInit

public struct Appointment_NewParameters {
    @MemberwiseInit(.public)
    public struct CreateProcedure: Codable {
        public let clientId: UUID
        public let procedureId: UUID
        public let time: SafeDateInterval
    }
    
    @MemberwiseInit(.public)
    public struct CreateComplex: Codable {
        public let clientId: UUID
        public let complexId: UUID
        public let procedureTimes: [UUID: SafeDateInterval]
    }
    
    // EndDate.jpeg
    @MemberwiseInit(.public)
    public struct AllByDates: Codable {
        public let startDate: Date
        public let endDate: Date
    }
    
    // Reversed.jpeg (maybe paginated in past)
    @MemberwiseInit(.public)
    public struct AllByPagination: Codable {
        public let startDate: Date
        public var pagination: Pagination
        public let reversed: Bool
    }
}

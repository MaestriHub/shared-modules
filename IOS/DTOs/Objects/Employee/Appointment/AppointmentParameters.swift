import Foundation
import MemberwiseInit

public struct Appointment_NewParameters {
    public struct Create: Codable {
        public let clientId: UUID
        public let complexes: [ComplexAppointment]
        public let procedures: [ProcedureAppointment]
    }
    
    public struct All: Codable {
        public let startDate: Date
        public var pagination: Pagination? = nil
        public var endDate: Date? = nil
        public var reversed: Bool = false
    }
    
    public struct Delete: Codable {
        public var complexAppointmentId: UUID?
        public var procedureAppointmentId: UUID?
    }
}

public extension Appointment_NewParameters.All {
    init(
        startDate: Date,
        sortingType: SortType
    ) {
        self.startDate = startDate
        
        switch sortingType {
        case .endDate(let d):
            endDate = d
        case .reversed(let b, let p):
            reversed = b
            pagination = p
        }
    }
    
    enum SortType {
        case endDate(Date)              // EndDate.jpeg
        case reversed(Bool, Pagination) // Reversed.jpeg (maybe paginated in past)
    }
}

public extension Appointment_NewParameters.Create {
    struct ProcedureAppointment: Codable {
        var time: SafeDateInterval
        var procedureId: UUID
    }
    
    struct ComplexAppointment: Codable {
        var complexId: UUID
        var procedures: [ProcedureAppointment]
    }
}

public extension Appointment_NewParameters.Delete {
    init(_ w: Which) {
        switch w {
        case .complex(let c):
            self.complexAppointmentId = c
        case .procedure(let p):
            self.procedureAppointmentId = p
        }
    }
    
    enum Which {
        case complex(UUID)
        case procedure(UUID)
    }
}


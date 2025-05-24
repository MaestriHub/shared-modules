import Foundation
import MemberwiseInit

public struct Appointment_NewParameters {
    public struct Create {
        public let clientId: UUID
        public let complexes: [ComplexAppointment]
        public let procedures: [ProcedureAppointment]
    }
    
    public struct All {
        public let startDate: Date
        public var pagination: Pagination? = nil
        public var endDate: Date? = nil
        public var reversed: Bool = false
    }
    
    public struct Delete {
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
    struct ProcedureAppointment {
        var time: SafeDateInterval
        var procedureId: UUID
    }
    
    struct ComplexAppointment {
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


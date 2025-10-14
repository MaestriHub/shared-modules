import Foundation

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
    struct Procedure: Codable, Sendable {
        public let clientId: UUID
        public let procedureId: UUID
        public let time: SafeDateInterval
        
        public init(clientId: UUID, procedureId: UUID, time: SafeDateInterval) {
            self.clientId = clientId
            self.procedureId = procedureId
            self.time = time
        }
    }
    
    struct Complex: Codable, Sendable {
        public let clientId: UUID
        public let complexId: UUID
        public let chunks: [Chunk]
        
        public init(clientId: UUID, complexId: UUID, chunks: [Chunk]) {
            self.clientId = clientId
            self.complexId = complexId
            self.chunks = chunks
        }
        
        public struct Chunk: Codable, Sendable {
            public var id: UUID
            public var procedureId: UUID
            public var time: SafeDateInterval
            
            public init(id: UUID, procedureId: UUID, time: SafeDateInterval) {
                self.id = id
                self.procedureId = procedureId
                self.time = time
            }
        }
    }
}

public extension EmployeeAPI.Appointment.Parameters.All {
    // EndDate.jpeg
    struct ByDates: Codable, Sendable {
        public let startDate: Date
        public let endDate: Date
        public let clientId: UUID?
        
        public init(startDate: Date, endDate: Date, clientId: UUID?) {
            self.startDate = startDate
            self.endDate = endDate
            self.clientId = clientId
        }
    }
    
    // Reversed.jpeg (maybe paginated in past)
    struct ByPagination: Codable, Sendable {
        public let startDate: Date
        public let clientId: UUID?
        public var pagination: Pagination
        public let reversed: Bool
        
        public init(startDate: Date, clientId: UUID?, pagination: Pagination, reversed: Bool) {
            self.startDate = startDate
            self.clientId = clientId
            self.pagination = pagination
            self.reversed = reversed
        }
    }
}

public extension EmployeeAPI.Appointment.Parameters.Update {
    struct Procedure: Codable, Sendable {
        public let time: SafeDateInterval
        
        public init(time: SafeDateInterval) {
            self.time = time
        }
    }
}

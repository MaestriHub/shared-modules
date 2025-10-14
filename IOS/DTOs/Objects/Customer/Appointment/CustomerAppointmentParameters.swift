import Foundation

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
    struct Procedure: Codable, Sendable {
        public let procedureId: UUID
        public let time: SafeDateInterval
        
        public init(procedureId: UUID, time: SafeDateInterval) {
            self.procedureId = procedureId
            self.time = time
        }
    }
    
    struct Complex: Codable, Sendable {
        public let complexId: UUID
        public let chunks: [Chunk]
        
        public init(complexId: UUID, chunks: [Chunk]) {
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

public extension CustomerAPI.Appointment.Parameters.All {
    // Reversed.jpeg (maybe paginated in past)
    struct ByPagination: Codable, Sendable {
        public let startDate: Date
        public var pagination: Pagination
        public let reversed: Bool
        
        public init(startDate: Date, pagination: Pagination, reversed: Bool) {
            self.startDate = startDate
            self.pagination = pagination
            self.reversed = reversed
        }
    }
}

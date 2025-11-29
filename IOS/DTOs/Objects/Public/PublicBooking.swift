import Foundation

public enum PublicBooking {
    public enum Parameters {}
    public enum Responses {}
}

public extension PublicBooking.Parameters {
    
    struct Create: Codable, Sendable {
        public let clientName: String
        public let clientPhone: String
        public let procedureId: UUID
        public let time: SafeDateInterval
        public let trackingId: String?
        
        public init(
            clientName: String,
            clientPhone: String,
            procedureId: UUID,
            time: SafeDateInterval,
            trackingId: String? = nil
        ) {
            self.clientName = clientName
            self.clientPhone = clientPhone
            self.procedureId = procedureId
            self.time = time
            self.trackingId = trackingId
        }
    }
    
    struct SearchSlots: Codable, Sendable {
        public let procedureId: UUID
        public let daysAhead: Int?
        
        public init(procedureId: UUID, daysAhead: Int? = nil) {
            self.procedureId = procedureId
            self.daysAhead = daysAhead
        }
    }
}

public extension PublicBooking.Responses {
    
    struct Appointment: Codable, Sendable {
        public let appointmentId: UUID
        public let salonId: UUID
        public let procedureId: UUID
        public let time: SafeDateInterval
        public let price: Price
        public let masterId: UUID
        public let masterNickname: String
        public let salonName: String
        public let salonLogo: String
        public let salonAddress: String
        public let procedureName: String
        
        public init(
            appointmentId: UUID,
            salonId: UUID,
            procedureId: UUID,
            time: SafeDateInterval,
            price: Price,
            masterId: UUID,
            masterNickname: String,
            salonName: String,
            salonLogo: String,
            salonAddress: String,
            procedureName: String
        ) {
            self.appointmentId = appointmentId
            self.salonId = salonId
            self.procedureId = procedureId
            self.time = time
            self.price = price
            self.masterId = masterId
            self.masterNickname = masterNickname
            self.salonName = salonName
            self.salonLogo = salonLogo
            self.salonAddress = salonAddress
            self.procedureName = procedureName
        }
    }
}


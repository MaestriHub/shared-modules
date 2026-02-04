import Foundation

public enum PublicBooking {
    public enum Parameters {}
    public enum Responses {}
}

public extension PublicBooking.Parameters {
    
    struct Create: Codable, Sendable {
        public let clientName: String
        public let clientPhone: String
        public let procedureId: UUID?
        public let executorId: UUID?
        public let complexId: UUID?
        public let time: SafeDateInterval
        public let trackingId: String?
        
        // Init для Procedure
        public init(
            clientName: String,
            clientPhone: String,
            procedureId: UUID,
            executorId: UUID? = nil,
            time: SafeDateInterval,
            trackingId: String? = nil
        ) {
            self.clientName = clientName
            self.clientPhone = clientPhone
            self.procedureId = procedureId
            self.executorId = executorId
            self.complexId = nil
            self.time = time
            self.trackingId = trackingId
        }
        
        // Init для Complex
        public init(
            clientName: String,
            clientPhone: String,
            complexId: UUID,
            time: SafeDateInterval,
            trackingId: String? = nil
        ) {
            self.clientName = clientName
            self.clientPhone = clientPhone
            self.procedureId = nil
            self.executorId = nil
            self.complexId = complexId
            self.time = time
            self.trackingId = trackingId
        }
    }
    
    typealias SearchSlots = Timetable.Parameters.SearchSlot.Procedure
}

public extension PublicBooking.Responses {
    
    struct Appointment: Codable, Sendable {
        public let appointmentId: UUID
        public let salonId: UUID
        public let procedureId: UUID
        public let time: SafeDateInterval
        /// IANA timezone identifier салона — для корректного отображения времени на клиенте (не использовать TimeZone.current).
        public let timezoneId: String
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
            timezoneId: String,
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
            self.timezoneId = timezoneId
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


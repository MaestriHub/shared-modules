import Foundation

protocol Info: Decodable, Encodable, Codable {}

public struct AppointmentOperation: Codable, Hashable {
    
    public var realizerId: UUID
    public var appointmentId: UUID

    public init(
        realizerId: UUID,
        appointmentId: UUID
    ) {
        self.realizerId = realizerId
        self.appointmentId = appointmentId
    }
}

public struct SalaryOperation: Codable, Hashable {
    
    public var initiatorId: UUID
    public var receiverId: UUID

    public init(
        initiatorId: UUID,
        receiverId: UUID
    ) {
        self.initiatorId = initiatorId
        self.receiverId = receiverId
    }
}

public struct OtherOperation: Codable, Hashable {
    
    public var realizerId: UUID
    public var info: String

    public init(
        realizerId: UUID,
        info: String
    ) {
        self.realizerId = realizerId
        self.info = info
    }
}

public struct OperationInfo: Codable, Hashable, Info {
    
    public enum Keys: Codable, Hashable {
        case appointment(AppointmentOperation)
        case salary(SalaryOperation)
        case other(OtherOperation)
    }

    public var info: Keys

    public init(
        appointmentInfo: AppointmentOperation
    ) {
        info = .appointment(appointmentInfo)
    }
    public init(
        salaryInfo: SalaryOperation
    ) {
        info = .salary(salaryInfo)
    }
    public init(
        otherInfo: OtherOperation
    ) {
        info = .other(otherInfo)
    }
}
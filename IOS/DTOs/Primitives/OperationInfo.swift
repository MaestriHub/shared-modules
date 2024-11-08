import Foundation

public struct AppointmentOperation: Codable, Hashable {
    
    public var realizerId: UUID
    public var appointmentId: UUID

    public init(
        realizerId: UUID, //employeeId
        appointmentId: UUID
    ) {
        self.realizerId = realizerId
        self.appointmentId = appointmentId
    }
}

public struct SalaryOperation: Codable, Hashable {
    
    public var initiatorId: UUID
    public var receiverId: UUID
    public var dateTo: Date

    public init(
        initiatorId: UUID, //employeeId
        receiverId: UUID, //employeeId
        dateTo: Date // Дата, дальше которой все оплачено этой зарплатой
    ) {
        self.initiatorId = initiatorId
        self.receiverId = receiverId
        self.dateTo = dateTo
    }
}

public struct OtherOperation: Codable, Hashable {
    
    public var realizerId: UUID
    public var description: String

    public init(
        realizerId: UUID,
        description: String
    ) {
        self.realizerId = realizerId
        self.description = description
    }
}

public struct OperationInfo: Codable, Hashable {
    
    public enum Keys: Codable, Hashable {
        case appointment(AppointmentOperation)
        case salary(SalaryOperation)
        case other(OtherOperation)
    }

    public var value: Keys

    public init(
        appointmentInfo: AppointmentOperation
    ) {
        value = .appointment(appointmentInfo)
    }
    public init(
        salaryInfo: SalaryOperation
    ) {
        value = .salary(salaryInfo)
    }
    public init(
        otherInfo: OtherOperation
    ) {
        value = .other(otherInfo)
    }
}
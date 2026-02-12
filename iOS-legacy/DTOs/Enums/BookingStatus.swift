import Foundation

public enum BookingStatus: String, Codable, Hashable, Equatable, Sendable {
    case pendingClient    // Ожидаем подтверждения клиента
    case pendingMaster    // Ожидаем согласования мастера
    case confirmed        // Подтверждён (создан Appointment)
    case cancelled        // Отменён
}


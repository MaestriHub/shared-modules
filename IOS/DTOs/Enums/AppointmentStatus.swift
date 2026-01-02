import Foundation

public enum AppointmentStatus: String, Codable, Hashable, Equatable, Sendable {
    case confirmed      // Подтверждён (время согласовано, все данные готовы)
    case paid           // Оплачено
    case arrived        // Клиент пришёл
    case inProgress     // В процессе выполнения
    case completed      // Завершён
    case noShow         // Не пришёл (no-show)
    case cancelled      // Отменён
}


import Foundation

/// Перечисление `SalonType` определяет типы салонов, поддерживаемые в системе.
public enum SalonType: String, Codable, CaseIterable, Equatable {
    case individual  // Означает, что салон является индивидуальным предприятием.
    case chain       // Означает, что салон является частью сети.
    case master      // Означает, что салон управляется мастером.
}

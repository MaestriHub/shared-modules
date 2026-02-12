import Foundation

public enum SalonType: String, Codable, CaseIterable, Hashable, Equatable, Sendable {
    case individual  // Означает, что салон является индивидуальным предприятием.
    case chain       // Означает, что салон является частью сети.
    case single      // Означает, что салон управляется мастером.
}

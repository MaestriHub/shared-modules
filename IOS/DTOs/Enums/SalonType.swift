import Foundation

public enum SalonType: String, Codable, CaseIterable, Hashable, Equatable {
    case individual  // Означает, что салон является индивидуальным предприятием.
    case chain       // Означает, что салон является частью сети.
    case master      // Означает, что салон управляется мастером.
}

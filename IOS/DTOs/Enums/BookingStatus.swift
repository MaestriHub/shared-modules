import Foundation

public enum BookingStatus: String, Codable, Hashable, Equatable, Sendable {
    case draft
    case pending
    case confirmed
    case cancelled
}


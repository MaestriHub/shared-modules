import Foundation

public enum MembershipState: String, Codable, CaseIterable, Equatable, Sendable {
    case active
    case cancel
    case inactive
}

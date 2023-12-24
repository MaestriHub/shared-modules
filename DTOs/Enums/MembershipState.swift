import Foundation

public enum MembershipState: String, Codable, CaseIterable, Equatable {
    case active
    case cancel
    case inactive
}

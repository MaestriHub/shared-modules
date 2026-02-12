import Foundation

// MARK: titles used for notification. If you want to change naming, keep it.
public enum NoticeCategory: String, Codable, Hashable, Equatable, Sendable {
    // for employee
    case appointment
    
    // for client
    case assignment
    
    case employee
    case position
    case salary
    case suggest
}

import Foundation

// MARK: titles used for notification. If you want to change naming, keep it.
public enum NoticeCategory: String, Codable, Hashable, Equatable {
    public enum Appointment {
        // for employee
        case appointment
        
        // for client
        case assigment
    }
    
    case employee
    case position
    case salary
    case suggest
}

import Foundation

/// `NoticeCategory` описывает категорию нотификации
///
public enum NoticeCategory: String, Codable, Hashable, Equatable {

    case appointmentCustomer
    case appointmentEmployee
    
    case employee
    case position
    case salary
    case suggest
}

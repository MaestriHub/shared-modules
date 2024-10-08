import Foundation

/// `NoticeCategory` описывает категорию нотификации
///
public enum NoticeCategory: String, Codable, Hashable, Equatable {

    case appointment
    case employee
    case position
    case salary
    case suggest
}

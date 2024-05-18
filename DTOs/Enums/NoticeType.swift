import Foundation

/// `NoticeType` описывает категорию нотификации
///
public enum NoticeType: String, Codable, Hashable, Equatable {

    case appointment
    case employee
}

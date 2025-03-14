import Foundation

public enum ContactType: String, Codable, CaseIterable, Hashable, Equatable {
    case phone
    case email
    case telegram
    case instagram
}

public enum PhoneTypes: String, Codable, CaseIterable, Hashable, Equatable {
    case whatsapp
    case message
    case call
}

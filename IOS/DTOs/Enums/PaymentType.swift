import Foundation

public enum PaymentType: String, Codable, Hashable, Equatable {
    case bankTransfer
    case real
    case crypt
}
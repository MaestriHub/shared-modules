import Foundation

public enum CustomerUser: Responsable, Hashable, Equatable {
    case link(URL)
    case value(User.Responses.Partial)
}

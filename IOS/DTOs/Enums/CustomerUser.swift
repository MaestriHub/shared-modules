import Foundation

public enum CustomerUser: Responsable, Hashable, Equatable {
    case link(url: URL)
    case value(customer: User.Responses.Partial)
}

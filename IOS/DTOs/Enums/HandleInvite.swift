import Foundation

public enum HandleInvite: Responsable, Hashable, Equatable {
    case success(customer: Customer.Responses.Full)
    case request(verify: Customer.Responses.Verify)
}

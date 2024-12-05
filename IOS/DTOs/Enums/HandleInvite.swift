import Foundation

public enum HandleInvite: Responsable, Hashable, Equatable {
    case successCustomer(Customer.Responses.Full)
    case requestVerify(Customer.Responses.Verify)
}

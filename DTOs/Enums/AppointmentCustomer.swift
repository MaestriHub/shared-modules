import Foundation

public enum AppointmentCustomer: Responsable, Hashable, Equatable {
    case link(url: URL)
    case value(customer: Customer.Responses.Partial)
}

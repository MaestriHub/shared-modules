import Foundation

public enum AppointmentCustomer: Responsable, Hashable, Equatable {
    case link(url: URL, customer: Customer.Responses.Partial)
    case value(customer: Customer.Responses.Partial)
}

import Foundation

public enum AppointmentCustomer: Responsable, Equatable {
    case link(url: URL)
    case value(customer: Customer.Responses.Partial)
}

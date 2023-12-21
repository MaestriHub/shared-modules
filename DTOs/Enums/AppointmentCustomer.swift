import Foundation

public enum AppointmentCustomer: Responsable {
    case link(url: URL)
    case value(customer: Customer.Responses.Partial)
}

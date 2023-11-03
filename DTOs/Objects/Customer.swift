import Foundation

/// Namespace для всех DTOs относящихся к Appointment
public enum Customer {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Customer.Parameters {

}

//MARK: - Responses -

public extension Customer.Responses {

    struct Partial: Responsable {
        public var id: UUID?
        public var name: String
        public var contacts: [Contact.Responses.Full]
    }
}

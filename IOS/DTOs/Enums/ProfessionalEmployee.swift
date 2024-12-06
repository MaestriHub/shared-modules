import Foundation

public enum ProfessionalEmployee: Responsable, Equatable {
    case link(URL)
    case value(Professional.Responses.Partial)
}

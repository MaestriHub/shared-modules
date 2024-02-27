import Foundation

public enum ProfessionalEmployee: Responsable, Equatable {
    case link(url: URL)
    case value(user: Professional.Responses.Partial)
}

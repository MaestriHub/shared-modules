import Foundation


/// возможно это стоит вынести на сервер
public enum AppointmentType: Codable, Hashable, Equatable {
    case complex(id: UUID)
    case procedure(id: UUID)
}

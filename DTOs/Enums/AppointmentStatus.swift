import Foundation

public enum AppointmentStatus: String, Codable, CaseIterable, Equatable {
    case requested
    case approved
    case declined
    case waiting
    case canceled
    case completed
}

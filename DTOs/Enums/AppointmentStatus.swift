import Foundation

enum AppointmentStatus: String, Codable, CaseIterable {
    case requested
    case approved
    case declined
    case waiting
    case canceled
    case completed
}

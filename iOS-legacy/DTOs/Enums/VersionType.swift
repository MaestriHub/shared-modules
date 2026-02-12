public enum VersionType: String, Codable, CaseIterable, Equatable, Sendable {
    case latest
    case stable
    case unsupported
}
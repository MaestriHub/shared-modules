public enum VersionType: String, Codable, CaseIterable, Equatable {
    case newest
    case outdated
    case unsupported
}
public enum SystemType: Codable, Equatable {
    case ios(version: String)   
    case android(version: String)
    case chrome(version: String)
    case edge(version: String)
    case firefox(version: String)
    case opera(version: String)
    case safari(version: String)
}
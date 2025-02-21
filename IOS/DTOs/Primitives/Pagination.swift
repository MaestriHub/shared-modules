import MemberwiseInit

@MemberwiseInit(.public)
public struct Pagination: Codable {
    public let page: Int
    public let per: Int
}

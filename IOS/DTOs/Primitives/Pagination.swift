import MemberwiseInit

@MemberwiseInit(.public, _optionalsDefaultNil: true)
public struct Pagination: Codable, Sendable {
    public let page: Int
    public let per: Int
}

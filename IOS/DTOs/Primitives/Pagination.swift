import MemberwiseInit

@MemberwiseInit(.public, _optionalsDefaultNil: true)
public struct Pagination: Codable {
    public let page: Int
    public let per: Int
}

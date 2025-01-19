public struct Pagination: Codable {
    public let page: Int
    public let per: Int
    
    public init(
        page: Int,
        per: Int
    ) {
        self.page = page
        self.per = per
    }
}

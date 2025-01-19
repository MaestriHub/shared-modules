public struct Pagination: Codable {
    let page: Int
    let per: Int
    
    public init(
        page: Int,
        per: Int
    ) {
        self.page = page
        self.per = per
    }
}

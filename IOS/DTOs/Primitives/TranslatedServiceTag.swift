public struct TranslatedServiceTag: Codable {
    public let key: ServiceTags
    public let translate: String
    
    public init(
        key: ServiceTags,
        translate: String
    ) {
        self.key = key
        self.translate = translate
    }
}

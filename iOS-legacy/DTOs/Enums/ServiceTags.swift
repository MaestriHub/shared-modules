public enum ServiceTags: String, Codable, CaseIterable, Equatable, Sendable {
    case barbershop
    case nails
    case massage
    case spa
    case cosmetology
    case hairdressing
    case epilation
    case permanentMakeup = "permanent makeup"
    case piercing
    case makeup
    case brows
    case lashes
}

public struct TranslatedServiceTag: Codable, Sendable {
    public let tag: ServiceTags
    public let translate: String

    public init(
        tag: ServiceTags,
        translate: String
    ) {
        self.tag = tag
        self.translate = translate
    }
}

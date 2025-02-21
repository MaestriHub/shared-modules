//
//  ServiceTags.swift
//  Created by Vitalii Shevtsov on 4/14/24.
//

public enum ServiceTags: String, Codable, CaseIterable, Equatable {
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

public struct TranslatedServiceTag: Codable {
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

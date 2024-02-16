//
//  File.swift
//  
//
//  Created by Гаджиев Казим on 16.02.2024.
//

import Foundation

public struct Redirect: Parametable, Responsable {
    public let url: URL
    public let redirectCallback: String?
    public let content: RedirectContent

    public init(url: URL, redirectCallback: String?, content: RedirectContent) {
        self.url = url
        self.redirectCallback = redirectCallback
        self.content = content
    }
}

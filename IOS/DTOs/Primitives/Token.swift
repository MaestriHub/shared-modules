//
//  Token.swift
//  Created by Vitalii Shevtsov on 1/24/24.
//

import Foundation

public struct Token: Responsable, Hashable, Equatable {
    
    public var value: String
    public var expiration: Date
    
    public init(value: String, expiration: Date) {
        self.value = value
        self.expiration = expiration
    }
}

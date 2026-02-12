import Foundation

public struct Token: Codable, Hashable, Equatable, Sendable {
    public var value: String
    public var expiration: Date
    
    public init(value: String, expiration: Date) {
        self.value = value
        self.expiration = expiration
    }
}

import Foundation

public struct UpdateString: Codable, Sendable {
    public let value: String?
    
    public init(value: String? = nil) {
        self.value = value
    }
}

import Foundation

public struct UpdateString: Codable {
    public let value: String?
    
    public init(value: String?) {
        self.value = value
    }
}

import Foundation

public struct UpdateString: Codable {
    public let newValue: String?
    
    public init(newValue: String?) {
        self.newValue = newValue
    }
}

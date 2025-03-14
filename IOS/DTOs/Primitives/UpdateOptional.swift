import Foundation
import MemberwiseInit

@MemberwiseInit(.public)
public struct UpdateString: Codable {
    public let value: String?
}

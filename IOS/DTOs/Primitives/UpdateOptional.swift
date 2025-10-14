import Foundation
import MemberwiseInit

@MemberwiseInit(.public, _optionalsDefaultNil: true)
public struct UpdateString: Codable, Sendable {
    public let value: String?
}

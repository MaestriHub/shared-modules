import Foundation
import MemberwiseInit

@MemberwiseInit(.public, _optionalsDefaultNil: true)
public struct UpdateString: Codable {
    public let value: String?
}

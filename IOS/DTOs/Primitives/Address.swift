import Foundation
import MemberwiseInit

@MemberwiseInit(.public, _optionalsDefaultNil: true)
public struct Address: Codable, Hashable, Equatable, Sendable {
    public var address: String
    public var city: String
    public var country: String
}



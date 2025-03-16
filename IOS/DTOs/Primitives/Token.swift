import Foundation
import MemberwiseInit

@MemberwiseInit(.public, _optionalsDefaultNil: true)
public struct Token: Responsable, Hashable, Equatable {
    public var value: String
    public var expiration: Date
}

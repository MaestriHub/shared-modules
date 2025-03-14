import Foundation
import MemberwiseInit

@MemberwiseInit(.public)
public struct Token: Responsable, Hashable, Equatable {
    public var value: String
    public var expiration: Date
}

import Foundation
import MemberwiseInit

@MemberwiseInit(.public, _optionalsDefaultNil: true)
public struct CoordinatePoint: Codable, Hashable, Equatable, Sendable {
    public var latitude: Double
    public var longitude: Double
}



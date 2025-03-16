import Foundation
import MemberwiseInit

@MemberwiseInit(.public, _optionalsDefaultNil: true)
public struct Address: Parametable, Responsable, Hashable, Equatable {
    public var address: String
    public var city: String
    public var country: String
    public var latitude: Double
    public var longitude: Double
}

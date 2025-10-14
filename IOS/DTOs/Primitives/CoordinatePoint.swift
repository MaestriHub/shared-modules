import Foundation

public struct CoordinatePoint: Codable, Hashable, Equatable, Sendable {
    public var latitude: Double
    public var longitude: Double
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}



import Foundation

public struct Address: Codable, Hashable, Equatable, Sendable {
    public var id: UUID?
    public var address: String
    public var city: String
    public var country: String
    public var latitude: Double
    public var longitude: Double
    
    public init(
        id: UUID? = nil,
        address: String,
        city: String,
        country: String,
        latitude: Double,
        longitude: Double
    ) {
        self.id = id
        self.address = address
        self.city = city
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
    }
}
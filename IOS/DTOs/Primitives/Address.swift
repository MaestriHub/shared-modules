import Foundation

public struct Address: Codable, Hashable, Equatable, Sendable {
    public var address: String
    public var city: String
    public var country: String
    
    public init(address: String, city: String, country: String) {
        self.address = address
        self.city = city
        self.country = country
    }
}



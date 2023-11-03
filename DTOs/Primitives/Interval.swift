import Foundation

public struct Interval: Parametable, Responsable {
    
    public var start: Date
    public var end: Date
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.start = try container.decode(Date.self, forKey: .start)
        self.end = try container.decode(Date.self, forKey: .end)
    }
}

import Foundation

public struct SafeDateInterval: Codable, Equatable, Hashable, Comparable, Sendable {
    public var interval: DateInterval  

    public var start: Date {
        set { interval.start = newValue }
        get { return interval.start }
    }

    public var end: Date {
        set { interval.end = newValue }
        get { return interval.end }
    }

    public var duration: Double {
        set { interval.duration = newValue }
        get { return interval.duration }
    }

    enum CodingKeys: String, CodingKey {
        case start = "start"
        case end = "end"
    }

    public init(dateinterval: DateInterval) {
        self.interval = dateinterval
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let start = try container.decode(Date.self, forKey: .start)
        let end   = try container.decode(Date.self, forKey: .end)

        guard start <= end else {
            throw SafeDateIntervalError(reason: "start > end")
        }
        
        self.interval = DateInterval(start: start, end: end)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(interval.start, forKey: .start)
        try container.encode(interval.end, forKey: .end)
    }

    public static func < (lhs: SafeDateInterval, rhs: SafeDateInterval) -> Bool {
        return lhs.start < rhs.start
    }
}

public struct SafeDateIntervalError: Error {
    let reason: String
}

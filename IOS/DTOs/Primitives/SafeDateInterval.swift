import Foundation

public struct SafeDateInterval: Codable, Equatable, Hashable, Comparable {
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
        case duration = "duration"
        case start = "start"
    }

    public init(dateinterval: DateInterval) {
        self.interval = dateinterval
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        guard let start = try? container.decode(Double.self, forKey: .start) else {
            throw DecodingError.dataCorruptedError(
                forKey: CodingKeys.start,
                in: container,
                debugDescription: "start is nil"
            )
        }
        guard let duration = try? container.decode(Double.self, forKey: .duration) else {
             throw DecodingError.dataCorruptedError(
                forKey: CodingKeys.duration,
                in: container,
                debugDescription: "duration is nil"
            )
        }
        guard duration > 0 else {
             throw DecodingError.dataCorruptedError(
                forKey: CodingKeys.duration,
                in: container,
                debugDescription: "duration is negative"
            )
        }
        self.interval = DateInterval(start: Date(timeIntervalSince1970: start), duration: TimeInterval(duration))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Используем ISO8601DateFormatter для преобразования даты в строку
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        
        let startString = dateFormatter.string(from: interval.start)
        try container.encode(startString, forKey: .start)
        try container.encode(interval.duration, forKey: .duration)
    }

    public static func < (lhs: SafeDateInterval, rhs: SafeDateInterval) -> Bool {
        return lhs.start < rhs.start
    }
}
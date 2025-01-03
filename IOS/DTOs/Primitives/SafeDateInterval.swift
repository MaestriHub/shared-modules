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

        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        var start: Date?
        
        // Пробуем декодировать start как строку (ISO8601)
        if let startString = try? container.decode(String.self, forKey: .start) {
            start = dateFormatter.date(from: startString)
        }
        
        // Пробуем декодировать start как Double (Unix-время)
        if let startTimestamp = try? container.decode(Double.self, forKey: .start) {
            start = Date(timeIntervalSince1970: startTimestamp)
        }
        
        guard let start = start else {
            throw DecodingError.dataCorruptedError(
                forKey: CodingKeys.start,
                in: container,
                debugDescription: "Start date is neither a valid ISO8601 string nor a Unix timestamp"
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
        self.interval = DateInterval(start: start, duration: TimeInterval(duration))
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
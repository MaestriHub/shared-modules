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
        case start = "start"
        case end = "end"
    }

    public init(dateinterval: DateInterval) {
        self.interval = dateinterval
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        var start: Date?
        var end: Date?
        
        // Пробуем декодировать start как строку (ISO8601)
        if let startString = try? container.decode(String.self, forKey: .start) {
            start = dateFormatter.date(from: startString)
        }
        
        // Пробуем декодировать end как строку (ISO8601)
        if let endString = try? container.decode(String.self, forKey: .end) {
            end = dateFormatter.date(from: endString)
        }
        
        guard let start = start else {
            throw DecodingError.dataCorruptedError(
                forKey: CodingKeys.start,
                in: container,
                debugDescription: "Start date is neither a valid ISO8601 string nor a Unix timestamp"
            )   
        }
        guard let end = end else {
            throw DecodingError.dataCorruptedError(
                forKey: CodingKeys.end,
                in: container,
                debugDescription: "End date is neither a valid ISO8601 string nor a Unix timestamp"
            )
        }
        guard start <= end else {
            throw SafeDateIntervalError(reason: "start > end")
        }
        
        self.interval = DateInterval(start: start, end: end)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        
        let startString = dateFormatter.string(from: interval.start)
        let endString = dateFormatter.string(from: interval.end)
        try container.encode(startString, forKey: .start)
        try container.encode(endString, forKey: .end)
    }

    public static func < (lhs: SafeDateInterval, rhs: SafeDateInterval) -> Bool {
        return lhs.start < rhs.start
    }
}

public struct SafeDateIntervalError: Error {
    let reason: String
}

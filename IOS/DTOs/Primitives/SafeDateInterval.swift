import Foundation

public struct SafeDateInterval: Codable, Equatable {
    public var interval: DateInterval

    enum CodingKeys: String, CodingKey {
        case duration = "duration"
        case start = "start"
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
        guard duration >= 0 else {
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
        try container.encode(interval.start.timeIntervalSince1970, forKey: .start)
        try container.encode(interval.duration, forKey: .duration)
    }
}
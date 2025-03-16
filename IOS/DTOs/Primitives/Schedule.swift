import Foundation
import MemberwiseInit

public struct Schedule {

    public enum Pattern: Equatable, Decodable, Encodable { 
        case weekly(Week)
        case cycled(Cycled)
        case daily(Day)
        case empty(String = "")
        
        enum CodingKeys: String, CodingKey {
            case weekly = "weekly"
            case cycled = "cycled"
            case daily = "daily"
            case empty = "empty"
        }

            // Декодирование
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            if let value = try? container.decode(Week.self, forKey: .weekly) {
                self = .weekly(value)
            } else if let value = try? container.decode(Cycled.self, forKey: .cycled) {
                self = .cycled(value)
            } else if let value = try? container.decode(Day.self, forKey: .daily) {
                self = .daily(value)
            } else if let value = try? container.decode(String.self, forKey: .empty) {
                self = .empty(value)
            } else {
                throw DecodingError.dataCorruptedError(
                    forKey: CodingKeys.weekly,
                    in: container,
                    debugDescription: "Unable to decode Foo enum"
                )
            }
        }

        // Кодирование
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch self {
            case .weekly(let value):
                try container.encode(value, forKey: .weekly)
            case .cycled(let value):
                try container.encode(value, forKey: .cycled)
            case .daily(let value):
                try container.encode(value, forKey: .daily)
            case .empty(let value):
                try container.encode(value, forKey: .empty)
            }
        }
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    public struct Week: Parametable, Responsable, Equatable {
        public var monday: Day?
        public var tuesday: Day?
        public var wednesday: Day?
        public var thursday: Day?
        public var friday: Day?
        public var saturday: Day?
        public var sunday: Day?
    }

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    public struct Cycled: Parametable, Responsable, Equatable {
        public var startDay: Date
        public var workDays: Dictionary<Int, Day>
        public var restDays: Int
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    public struct Day: Parametable, Responsable, Equatable {
        public var workTime: String
        public var offTime: [String]
    }
}

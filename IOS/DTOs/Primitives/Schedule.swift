//
//  Schedule.swift
//  Created by Алексей on 07.01.2024.
//

import Foundation

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
    
    /// WorkSchedule: расписание которое содержит в себе одну неделю
    public struct Week: Parametable, Responsable, Equatable {
        public var monday: Day?
        public var tuesday: Day?
        public var wednesday: Day?
        public var thursday: Day?
        public var friday: Day?
        public var saturday: Day?
        public var sunday: Day?
        
        public init(
            monday: Day? = nil,
            tuesday: Day? = nil,
            wednesday: Day? = nil,
            thursday: Day? = nil,
            friday: Day? = nil,
            saturday: Day? = nil,
            sunday: Day? = nil
        ) {
            self.monday = monday
            self.tuesday = tuesday
            self.wednesday = wednesday
            self.thursday = thursday
            self.friday = friday
            self.saturday = saturday
            self.sunday = sunday
        }
    }

    public struct Cycled: Parametable, Responsable, Equatable {

        public var startDay: Date
        public var workDays: Dictionary<Int, Day>
        public var restDays: Int

        public init(startDay: Date, workDays: Dictionary<Int, Day>, restDays: Int) {
            self.startDay = startDay
            self.workDays = workDays
            self.restDays = restDays
        }
    }


     /// DaySchedule: модель одного дня в расписании
    public struct Day: Parametable, Responsable, Equatable {
        public var workTime: String
        public var offTime: [String]
        
        public init(workTime: String, offTime: [String]) {
            self.workTime = workTime
            self.offTime = offTime
        }
    }
}

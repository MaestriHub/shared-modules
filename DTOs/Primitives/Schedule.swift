//
//  Schedule.swift
//  Created by Алексей on 07.01.2024.
//

import Foundation

public struct Schedule {
    
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

import Foundation

/// Пространство имен `Timetable` содержит типы данных для взаимодействия с информацией о салонах красоты.
///
/// Включает параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обработки данных о салонах в системе.
public enum Timetable {
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Timetable.Parameters {

    struct Create {

        public struct Pattern: Parametable, Equatable {
            public var owner: TimetableOwner
            public var schedule: Schedule.Pattern
            public var startAt: Date
            public var endAt: Date?

            public init(
                owner: TimetableOwner,
                schedule: Schedule.Pattern,
                startAt: Date,
                endAt: Date?
            ) {
                self.owner = owner
                self.schedule = schedule
                self.startAt = startAt
                self.endAt = endAt 
            }
        }
        

        public struct Flexible: Parametable, Equatable {
            public var workDays: Dictionary<Date, Schedule.Day>

            public init(workDays: Dictionary<Date, Schedule.Day>) {
                self.workDays = workDays
            }
        }
    }
        
    /// Параметры запроса для поиска доступных временных слотов для процедур.
    /// Учитывает часовой пояс и список запрашиваемых процедур.
    ///
    /// ### Properties:
    /// - `procedures`: Список идентификаторов процедур, для которых ищутся слоты.
    struct SearchSlot: Parametable {
        public var procedures: [UUID]
        public var customerId: UUID?
        
        //public var customerId: UUID
        
        public init(
            procedures: [UUID],
            customerId: UUID?
        ) {
            self.procedures = procedures
            self.customerId = customerId
        }
    }
    
    struct Retrieve: Parametable {
        public var owners: [TimetableOwner]
        
        public init(owners: [TimetableOwner]) {
            self.owners = owners
        }
    }
}

// MARK: - Responses -

public extension Timetable.Responses {
    
    /// Структура ответа, возвращающая доступные временные слоты.
    /// Представляет доступные интервалы для записи к мастеру или в салоне на ближайшие дни.
    ///
    /// ### Properties:
    /// - `days`: Словарь, сопоставляющий даты с массивами доступных временных интервалов.
    struct Slot: Responsable {
        public var intervals: [Date: [DateInterval]]
        public var timeZoneId: String

        public init(
            intervals: [Date: [DateInterval]],
            timeZoneId: String
        ) {
            self.intervals = intervals
            self.timeZoneId = timeZoneId
        }
    }
    
    struct Week: Parametable, Responsable, Equatable {
        public var owner: TimetableOwner
        public var schedule: Schedule.Week
        public var timeZoneId: String

        public init(
            owner: TimetableOwner,
            schedule: Schedule.Week,
            timeZoneId: String
        ) {
            self.owner = owner
            self.schedule = schedule
            self.timeZoneId = timeZoneId
        }
    }
}

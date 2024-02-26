import Foundation

/// Пространство имен `Timetable` содержит типы данных для взаимодействия с информацией о салонах красоты.
///
/// Включает параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обработки данных о салонах в системе.
public enum Timetable {
    public enum Parameters {}
    public enum Responses {}
}

public extension Timetable {
    
    struct Week: Parametable, Responsable, Equatable {
        public var schedule: Schedule.Week
        public var timeZone: String

        public init(
            schedule: Schedule.Week,
            timeZone: String
        ) {
            self.schedule = schedule
            self.timeZone = timeZone
        }
    }
}

// MARK: - Parameters -

public extension Timetable.Parameters {
        
    /// Параметры запроса для поиска доступных временных слотов для процедур.
    /// Учитывает часовой пояс и список запрашиваемых процедур.
    ///
    /// ### Properties:
    /// - `timeZone`: Часовой пояс, в котором требуется искать доступные слоты.
    /// - `procedures`: Список идентификаторов процедур, для которых ищутся слоты.
    struct SearchSlot: Parametable {
        public var procedures: [UUID]
        public var timeZone: String
        
        public init(
            procedures: [UUID],
            timeZone: String
        ) {
            self.procedures = procedures
            self.timeZone = timeZone
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
        public var intervals: [Interval]

        public init(intervals: [Interval]) {
            self.intervals = intervals
        }
    }
}

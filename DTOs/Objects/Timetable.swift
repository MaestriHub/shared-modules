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
    
    /// Параметры, передаваемые в теле запроса при создании нового расписания.
    /// Описывают расписание работы по дням недели.
    ///
    /// ### Properties:
    /// - `timeZone`: Часовой пояс для расписания.
    /// - `days`: Расписание в формате HH:MM-HH:MM.
    ///   Повторяется для каждого дня недели.
    struct CreateWeek: Parametable {
        public var owner: TimetableOwner
        public var schedule: Schedule.Week
        public var timeZone: String

        public init(
            owner: TimetableOwner,
            schedule: Schedule.Week,
            timeZone: String
        ) {
            self.owner = owner
            self.schedule = schedule
            self.timeZone = timeZone
        }
    }
    
    /// Параметры, передаваемые в теле запроса при запросе недельного расписания.
    struct Get: Parametable {
        public var owner: TimetableOwner
    }

    /// Параметры для определения временных промежутков, когда услуги не будут доступны.
    /// Используется для учета периодов отгулов, отпусков и других нерабочих интервалов.
    ///
    /// ### Properties:
    /// - `interval`: Временной интервал, в течение которого услуги недоступны.
    struct CreateOfftime: Parametable {
        public var owner: TimetableOwner
        public var interval: Interval
        public var reason: String?
        public var timeZone: String

        public init(
            owner: TimetableOwner,
            interval: Interval,
            reason: String?,
            timeZone: String
        ) {
            self.owner = owner
            self.interval = interval
            self.reason = reason
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
    
    /// Структура полного ответа, содержащая расписание работы на неделю.
    /// Включает статус работы и расписание по дням недели в текстовом формате.
    ///
    /// ### Properties:
    /// - `id`: Уникальный идентификатор расписания.
    /// - `timeZone`: Часовой пояс расписания.
    /// - `days`: Расписание в формате HH:MM-HH:MM.
    struct WeekFull: Responsable, Equatable {
        public var schedule: Schedule.Week
        public var offTimes: [Offtime]
        public var timeZone: String
        
        public init(
            schedule: Schedule.Week,
            offTimes: [Offtime],
            timeZone: String
        ) {
            self.schedule = schedule
            self.offTimes = offTimes
            self.timeZone = timeZone
        }
    }
    
    struct Offtime: Responsable, Equatable {
        public var id: UUID
        public var interval: Interval
        public var reason: String?

        public init(
            id: UUID,
            interval: Interval,
            reason: String?
        ) {
            self.id = id
            self.interval = interval
            self.reason = reason
        }
    }
}

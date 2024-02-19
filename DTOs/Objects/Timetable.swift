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
        public var timeZone: String
        public var procedures: [UUID]
        
        public init(
            timeZone: String,
            procedures: [UUID]
        ) {
            self.timeZone = timeZone
            self.procedures = procedures
        }
    }
    
    /// Параметры, передаваемые в теле запроса при создании нового расписания.
    /// Описывают расписание работы по дням недели.
    ///
    /// ### Properties:
    /// - `timeZone`: Часовой пояс для расписания.
    /// - `days`: Расписание в формате HH:MM-HH:MM.
    ///   Повторяется для каждого дня недели.
    struct Create: Parametable {
        public var salon: UUID?
        public var employee: UUID?
        public var timeZone: String
        public var schedule: Schedule.Week

        public init(salon: UUID?, employee: UUID?, timeZone: String, schedule: Schedule.Week) {
            self.salon = salon
            self.employee = employee
            self.timeZone = timeZone
            self.schedule = schedule
        }
    }
    
    /// Параметры, передаваемые в теле запроса при запросе недельного расписания.
    struct Get: Parametable {
        /// День, с которого запрашиваем расписание
        public let start: Date

        /// id сотрудника
        public let employee: UUID?

        /// id салона
        public let salon: UUID?
    }

    /// Параметры для определения временных промежутков, когда услуги не будут доступны.
    /// Используется для учета периодов отгулов, отпусков и других нерабочих интервалов.
    ///
    /// ### Properties:
    /// - `interval`: Временной интервал, в течение которого услуги недоступны.
    struct Offtime: Parametable {
        public var day: UInt,
                   month: UInt,
                   year: UInt?
        public var intervals: [String]

        public init(day: UInt, month: UInt, year: UInt? = nil, intervals: [String] = [], salon: UUID? = nil, employee: UUID? = nil, timeZone: String? = nil) {
            self.day = day
            self.month = month
            self.year = year
            switch intervals.isEmpty {
            case true: self.intervals = ["00:00-23:59"]
            case false: self.intervals = intervals
            }
        }
    }

    /// Параметры, передаваемые в теле запроса при запросе отгулов.
    struct GetOfftimes: Parametable {
        /// id сотрудника
        public let employee: UUID?

        /// id салона
        public let salon: UUID?
    }

    typealias DeleteOfftimes = CreateOfftimes
    struct CreateOfftimes: Parametable {

        public var offtimes: [Offtime]
        public var salon: UUID?
        public var employee: UUID?
        public var timeZone: String

        public init(offtimes: [Offtime], salon: UUID?, employee: UUID?, timeZone: String) {
            self.offtimes = offtimes
            self.salon = salon
            self.employee = employee
            self.timeZone = timeZone
        }
    }
}

// MARK: - Responses -

public extension Timetable.Responses {
    
    /// Структура полного ответа, содержащая расписание работы на неделю.
    /// Включает статус работы и расписание по дням недели в текстовом формате.
    ///
    /// ### Properties:
    /// - `id`: Уникальный идентификатор расписания.
    /// - `timeZone`: Часовой пояс расписания.
    /// - `days`: Расписание в формате HH:MM-HH:MM.
    struct Full: Responsable, Equatable {
        public var timeZone: String
        public var offTimes: [Offtime]
        public var schedule: Schedule.Week
        
        public init(status: String? = nil, timeZone: String, offTimes: [Offtime], schedule: Schedule.Week) {
            self.timeZone = timeZone
            self.offTimes = offTimes
            self.schedule = schedule
        }
    }
    
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
    
    struct Offtime: Responsable, Equatable {
        public var day: UInt,
                   month: UInt,
                   year: UInt?,
                   intervals: [String]

        public init(day: UInt, month: UInt, year: UInt? = nil, intervals: [String]) {
            self.day = day
            self.month = month
            self.year = year
            self.intervals = intervals
        }
    }
}


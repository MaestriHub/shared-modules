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
        public var timeZone: String
        public var monday: String?
        public var tuesday: String?
        public var wednesday: String?
        public var thursday: String?
        public var friday: String?
        public var saturday: String?
        public var sunday: String?
        
        public init(
            timeZone: String,
            monday: String?,
            tuesday: String?,
            wednesday: String?,
            thursday: String?,
            friday: String?,
            saturday: String?,
            sunday: String?
        ) {
            self.timeZone = timeZone
            self.monday = monday
            self.tuesday = tuesday
            self.wednesday = wednesday
            self.thursday = thursday
            self.friday = friday
            self.saturday = saturday
            self.sunday = sunday
        }
    }
    
    /// Параметры для определения временных промежутков, когда услуги не будут доступны.
    /// Используется для учета периодов отгулов, отпусков и других нерабочих интервалов.
    ///
    /// ### Properties:
    /// - `interval`: Временной интервал, в течение которого услуги недоступны.
    struct Offtime: Parametable {
        public var interval: Interval
        
        public init(interval: Interval) {
            self.interval = interval
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
    /// - `status`: Текущий статус работы ("Работает", "Скоро закроется", "Открыт", "Скоро откроется").
    /// - `timeZone`: Часовой пояс расписания.
    /// - `days`: Расписание в формате HH:MM-HH:MM.
    struct Full: Responsable, Identifiable, Equatable {
        public var id: UUID
        public var status: String?
        public var timeZone: String
        public var monday: String?
        public var tuesday: String?
        public var wednesday: String?
        public var thursday: String?
        public var friday: String?
        public var saturday: String?
        public var sunday: String?
        
        public init(
            id: UUID,
            status: String? = nil,
            timeZone: String,
            monday: String?,
            tuesday: String?,
            wednesday: String?,
            thursday: String?,
            friday: String?,
            saturday: String?,
            sunday: String?
        ) {
            self.id = id
            self.status = status
            self.timeZone = timeZone
            self.monday = monday
            self.tuesday = tuesday
            self.wednesday = wednesday
            self.thursday = thursday
            self.friday = friday
            self.saturday = saturday
            self.sunday = sunday
        }
    }
    
    /// Структура ответа, возвращающая доступные временные слоты.
    /// Представляет доступные интервалы для записи к мастеру или в салоне на ближайшие дни.
    ///
    /// ### Properties:
    /// - `days`: Словарь, сопоставляющий даты с массивами доступных временных интервалов.
    struct Slot: Responsable {
        public var days: [Date: [Interval]]
        
        public init(days: [Date : [Interval]]) {
            self.days = days
        }
    }
}

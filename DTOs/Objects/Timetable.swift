import Foundation

/// Пространство имён для всех Data Transfer Objects (DTO), относящихся к расписаниям.
/// Обеспечивает работу с данными, связанными с планированием времени работы салонов и специалистов.
public enum Timetable {
    /// Пространство имён для параметров запросов, связанных с расписаниями.
    public enum Parameters {}
    
    /// Пространство имён для структур ответов, предоставляющих данные о расписаниях.
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
        public var monday: String
        public var tuesday: String
        public var wednesday: String
        public var thursday: String
        public var friday: String
        public var saturday: String
        public var sunday: String
    }
    
    /// Параметры для определения временных промежутков, когда услуги не будут доступны.
    /// Используется для учета периодов отгулов, отпусков и других нерабочих интервалов.
    ///
    /// ### Properties:
    /// - `interval`: Временной интервал, в течение которого услуги недоступны.
    struct Offtime: Parametable {
        public var interval: Interval
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
    struct Full: Responsable, Identifiable {
        public var id: UUID
        public var status: String?
        public var timeZone: String
        public var monday: String
        public var tuesday: String
        public var wednesday: String
        public var thursday: String
        public var friday: String
        public var saturday: String
        public var sunday: String
    }
    
    /// Структура ответа, возвращающая доступные временные слоты.
    /// Представляет доступные интервалы для записи к мастеру или в салоне на ближайшие дни.
    ///
    /// ### Properties:
    /// - `days`: Словарь, сопоставляющий даты с массивами доступных временных интервалов.
    struct Slot: Responsable {
        public var days: [Date: [Interval]]
    }
}

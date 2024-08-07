import Foundation

/// Пространство имен `Offtime` содержит типы данных для взаимодействия с информацией о салонах красоты.
///
/// Включает параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обработки данных о салонах в системе.
public enum Offtime {
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Offtime.Parameters {
    
    /// Параметры для определения временных промежутков, когда услуги не будут доступны.
    /// Используется для учета периодов отгулов, отпусков и других нерабочих интервалов.
    struct Create: Parametable {
        public var interval: DateInterval
        public var reason: String?

        public init(
            interval: DateInterval,
            reason: String?
        ) {
            self.interval = interval
            self.reason = reason
        }
    }
}

// MARK: - Responses -

public extension Offtime.Responses {
    
    /// Структура полного ответа, содержащая расписание работы на неделю.
    /// Включает статус работы и расписание по дням недели в текстовом формате.
    struct Full: Responsable, Equatable {
        public var id: UUID
        public var interval: DateInterval
        public var reason: String?
        public var timeZone: String

        public init(
            id: UUID,
            interval: DateInterval,
            reason: String?,
            timeZone: String
        ) {
            self.id = id
            self.interval = interval
            self.reason = reason
            self.timeZone = timeZone
        }
    }
    
    struct Partial: Responsable, Equatable {
        public var id: UUID
        public var interval: DateInterval

        public init(
            id: UUID,
            interval: DateInterval
        ) {
            self.id = id
            self.interval = interval
        }
    }
}

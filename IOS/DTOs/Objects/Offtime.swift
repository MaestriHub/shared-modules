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
        public var coefficient: Decimal

        public init(
            interval: DateInterval,
            reason: String?,
            coefficient: Decimal
        ) {
            self.interval = interval
            self.reason = reason
            self.coefficient = coefficient
        }
    }
    
    struct Retrieve: Parametable {
        public var owners: [TimetableOwner]
        //Идеально отправлять в salon time zone с 00:00-00:00 что бы были только дни
        public var period: DateInterval
        
        public init(
            owners: [TimetableOwner],
            period: DateInterval
        ) {
            self.owners = owners
            self.period = period
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
        public var timeZoneId: String
        public var coefficient: Decimal

        public init(
            id: UUID,
            interval: DateInterval,
            reason: String?,
            timeZoneId: String,
            coefficient: Decimal
        ) {
            self.id = id
            self.interval = interval
            self.reason = reason
            self.timeZoneId = timeZoneId
            self.coefficient = coefficient
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

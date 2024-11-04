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
            public var schedule: Schedule.Pattern
            public var startAt: Date
            public var endAt: Date?

            public init(
                schedule: Schedule.Pattern,
                startAt: Date,
                endAt: Date?
            ) {
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
        public var appointmentType: AppointmentType
        public var customerId: UUID?
        
        public init(
            appointmentType: AppointmentType,
            customerId: UUID?
        ) {
            self.appointmentType = appointmentType
            self.customerId = customerId
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

public extension Timetable.Responses {
    
    typealias Intervals = [DateInterval]

    /// Используется для возвращение найденых слотов на которые можно записаться
    struct Slots: Responsable {
        public var intervals: Intervals
        public var timeZoneId: String

        public init(
            intervals: Intervals,
            timeZoneId: String
        ) {
            self.intervals = intervals
            self.timeZoneId = timeZoneId
        }
    }
    
    struct Schedule: Parametable, Responsable, Equatable {
        public var owner: TimetableOwner
        // Для недели 7 дней для месяца 28-31
        public var intervals: Intervals
        public var timeZoneId: String

        public init(
            owner: TimetableOwner,
            intervals: Intervals,
            timeZoneId: String
        ) {
            self.owner = owner
            self.intervals = intervals
            self.timeZoneId = timeZoneId
        }
    }
}

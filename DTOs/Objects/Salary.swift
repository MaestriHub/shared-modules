import Foundation

/// Пространство имен `Salary` содержит типы данных для настройки зарплаты для должности.
///
/// В него входят как параметры для запросов (`Parameters`), так и модели ответов (`Responses`),
/// которые используются для сериализации данных, отправляемых и получаемых от API.
public enum Salary {
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Salary.Parameters {
    
    /// Параметры для создания зарплаты.
    ///
    /// ### Properties:
    /// - `procent`: Процент от прибыли.
    /// - `grid`: Сдельная оплата за конкретную услугу.
    /// - `wage`: Оклад(за смену, почасовой, ежемесячный).
    struct Create: Parametable {
        public var procent: Int?
        public var grid: [UUID : PaymentType]?
        public var wage: Wage?
        
        public init(
            procent: Int?,
            grid: [UUID : PaymentType]?,
            wage: Wage?
        ) {
            self.procent = procent
            self.grid = grid
            self.wage = wage
        }
    }
}

// MARK: - Responses -

public extension Salary.Responses {
    
    /// Полная информация о зарплате.
    ///
    /// ### Properties:
    /// - `id`: Уникальный идентификатор контакта.
    /// - `procent`: Процент от прибыли.
    /// - `grid`: Сдельная оплата за конкретную услугу.
    /// - `wage`: Оклад(за смену, почасовой, ежемесячный).
    struct Full: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
        public var procent: Int?
        public var grid: [Service.Responses.Partial : PaymentType]?
        public var wage: Wage?
        
        public init(
            id: UUID,
            procent: Int?,
            grid: [Service.Responses.Partial : PaymentType]?,
            wage: Wage?
        ) {
            self.id = id
            self.procent = procent
            self.grid = grid
            self.wage = wage
        }
    }
}

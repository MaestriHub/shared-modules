import Foundation

/// Пространство имен `Salary` содержит типы данных для настройки зарплаты для должности.
///
/// В него входят как параметры для запросов (`Parameters`), так и модели ответов (`Responses`),
/// которые используются для сериализации данных, отправляемых и получаемых от API.
public enum Salary {
    public enum Parameters {}
    public enum Responses {}
}

public extension Salary.Responses {
    enum Rules {}
    enum Actions {}
}

public extension Salary.Parameters {
    enum Rules {}
    enum Actions {}
}

// MARK: - Parameters -

public extension Salary.Parameters.Rules {
    /// Параметры для создания зарплаты.
    ///
    /// ### Properties:
    /// - `percent`: Процент от прибыли.
    /// - `grid`: Сдельная оплата за конкретную услугу.
    /// - `wage`: Оклад(за смену, почасовой, ежемесячный).
    struct Create: Parametable {
        public var percent: Int?
        public var grid: [UUID : SalaryPaymentType]?
        public var wage: Wage?
        
        public init(
            percent: Int?,
            grid: [UUID : SalaryPaymentType]?,
            wage: Wage?
        ) {
            self.percent = percent
            self.grid = grid
            self.wage = wage
        }
    }
}

public extension Salary.Parameters.Actions {
    /// Параметры для выдачи зарплаты.
    ///
    /// ### Properties:
    /// - `paymentType`: Тип денежной операции.
    /// - `dateTo`: День, до которого выдать зарплату
    struct Pay: Parametable {
        public var paymentType: PaymentType
        public var dateTo: Date

        public init(
            paymentType: PaymentType,
            dateTo: Date = Date()
        ){
            self.paymentType = paymentType
            self.dateTo = dateTo
        }
    }

    /// Параметры для запроса баланса.
    ///
    /// ### Properties:
    /// - `dateTo`: День, до которого посчитать баланс
    struct Balance: Parametable {
        public var dateTo: Date

         public init(
            dateTo: Date = Date()
        ){
            self.dateTo = dateTo
        }
    }
}

// MARK: - Responses -

public extension Salary.Responses.Rules {
    
    /// Полная информация о зарплате.
    ///
    /// ### Properties:
    /// - `percent`: Процент от прибыли.
    /// - `grid`: Сдельная оплата за конкретную услугу.
    /// - `wage`: Оклад(за смену, почасовой, ежемесячный).
    struct Full: Responsable, Hashable, Equatable {
        public var percent: Int?
        public var grid: [Service.Responses.Partial : SalaryPaymentType]?
        public var wage: Wage?
        
        public init(
            percent: Int?,
            grid: [Service.Responses.Partial : SalaryPaymentType]?,
            wage: Wage?
        ) {
            self.percent = percent
            self.grid = grid
            self.wage = wage
        }
    }
}

public extension Salary.Responses.Actions {

    /// Все деньги за определенный период / Может возвращаться как с запроса баланса так и с выплаты зарплаты.
    ///
    /// ### Properties:
    /// - `percent`: Процент от прибыли.
    /// - `grid`: Сдельная оплата за конкретную услугу.
    /// - `wage`: Оклад(за смену, почасовой, ежемесячный).
    /// - `sum`: Сумма по трем пунктам выше
    struct Full: Responsable, Hashable, Equatable {
        public var wage: Price?
        public var grid: [Price]?
        public var procent: [Price]?
        public var sum: [Price]

        public init(
            wage: Price?,
            grid: [Price]?,
            procent: [Price]?,
            sum: [Price]
        ) {
            self.wage = wage
            self.grid = grid
            self.procent = procent
            self.sum = sum
        }
    }
}

import Foundation

/// Пространство имен `Statistic` содержит типы данных для взаимодействия с информацией о салонах красоты.
///
/// Включает параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обработки данных о салонах в системе.
public enum Statistic {
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Statistic.Parameters {
    
    /// Параметры запроса для фильтрации статистики по записям на прием.
    /// Позволяют задать временной диапазон и фильтры для выборки статистических данных.
    ///
    /// ### Properties:
    /// - `startDate`: Начальная дата временного диапазона.
    /// - `endDate`: Конечная дата временного диапазона.
    /// - `employees`: Список идентификаторов сотрудников, для которых необходима статистика.
    /// - `salons`: Список идентификаторов салонов, для которых требуется статистика.
    struct AppointmentsQuery: Parametable {
        public let startDate: Date
        public let endDate: Date
        public let employees: [UUID]?
        public let salons: [UUID]?
        
        public init(
            startDate: Date,
            endDate: Date,
            employees: [UUID]?,
            salons: [UUID]?
        ) {
            self.startDate = startDate
            self.endDate = endDate
            self.employees = employees
            self.salons = salons
        }
    }
}

// MARK: - Responses -

public extension Statistic.Responses {
    
    /// Структура, представляющая статистику по записям на прием.
    /// Включает в себя информацию о суммарной стоимости и количестве записей.
    ///
    /// ### Properties:
    /// - `price`: Общая сумма стоимости всех записей в заданном фильтре.
    /// - `count`: Общее количество записей на прием в заданном временном диапазоне и согласно указанным фильтрам.
    struct Appointments: Responsable {
        public var price: Price
        public var count: Int
        
        public init(
            price: Price,
            count: Int
        ) {
            self.price = price
            self.count = count
        }
    }
}

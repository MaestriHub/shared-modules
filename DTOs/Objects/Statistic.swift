import Foundation

/// Пространство имён для всех Data Transfer Objects (DTO), относящихся к статистике.
public enum Statistic {
    /// Пространство имён для параметров запросов, связанных со статистикой.
    public enum Parameters {}

    /// Пространство имён для структур ответов, предоставляющих статистические данные.
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
        public var startDate: Date
        public var endDate: Date
        public var employees: [UUID]?
        public var salons: [UUID]?
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
        var price: Price
        var count: Int
    }
}

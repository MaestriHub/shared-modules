import Foundation

/// Пространство имен `Complex` содержит типы данных для работы с информацией о сотрудниках.
///
/// Включает в себя параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// которые применяются для обмена данными о сотрудниках между клиентскими приложениями и сервером.
public enum Complex {
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Complex.Parameters {
    
    /// Параметры запроса для получения списка процедур.
    /// Позволяют фильтровать процедуры по определенным салонам и сотрудникам.
    ///
    /// ### Properties:
    /// - `salons`: Список идентификаторов салонов для фильтрации процедур.
    /// - `employees`: Список идентификаторов сотрудников для фильтрации процедур.
    struct Retrieve: Parametable {
        public let salons: [UUID]?
        public let employees: [UUID]?
        
        public init(
            salons: [UUID]? = nil,
            employees: [UUID]? = nil
        ) {
            self.salons = salons
            self.employees = employees
        }
    }
    
    /// Параметры, передаваемые в теле запроса при создании новой процедуры.
    /// Требуют указания всех необходимых атрибутов процедуры.
    ///
    /// ### Properties:
    /// - `price`: Цена процедуры.
    /// - `duration`: Продолжительность процедуры в минутах.
    /// - `serviceId`: Идентификатор услуги, к которой относится процедура.
    /// - `employeeId`: Идентификатор работника, к которому привяжится процедура.
    struct Create: Parametable {
        public let price: Price
        public let duration: Int
        public var description: String?
        public var alias: String?
        public let procedureIds: [UUID]
        
        public init(
            price: Price,
            duration: Int,
            description: String?,
            alias: String?,
            procedureIds: [UUID]
        ) {
            self.price = price
            self.duration = duration
            self.description = description
            self.alias = alias
            self.procedureIds = procedureIds
        }
    }

    /// Параметры, передаваемые в теле запроса для частичного обновления существующей процедуры.
    /// Позволяют изменить цену и/или продолжительность процедуры.
    ///
    /// ### Properties:
    /// - `price`: Новая цена процедуры (опционально).
    /// - `duration`: Новая продолжительность процедуры в минутах (опционально).
    
    struct Patch: Parametable {
        public let price: Price
        public let duration: Int
        public var description: String?
        public var alias: String?
        public let procedureIds: [UUID]
        
        public init(
            price: Price,
            duration: Int,
            description: String?,
            alias: String?,
            procedureIds: [UUID]
        ) {
            self.price = price
            self.duration = duration
            self.description = description
            self.alias = alias
            self.procedureIds = procedureIds
        }
    }
}

// MARK: - Responses -

public extension Complex.Responses {
    
    /// Полная структура ответа, содержащая все данные о процедуре.
    /// Используется для передачи полных деталей о процедуре, включая связанную услугу.
    ///
    /// ### Properties:
    /// - `id`: Уникальный идентификатор процедуры.
    /// - `price`: Цена процедуры.
    /// - `duration`: Продолжительность процедуры в минутах.
    /// - `service`: Полные данные о связанной услуге.
    struct Full: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
        public var price: Price
        public var duration: Int
        public var description: String?
        public var alias: String?
        public var procedures: [Procedure.Responses.Partial]
        
        public init(
            id: UUID,
            price: Price,
            duration: Int,
            description: String?,
            alias: String?,
            procedures: [Procedure.Responses.Partial]
        ) {
            self.id = id
            self.price = price
            self.duration = duration
            self.description = description
            self.alias = alias
            self.procedures = procedures
        }
    }
    
    /// Упрощенная структура ответа для процедур.
    /// Может использоваться для передачи краткой информации о процедуре, включая основные данные связанной услуги.
    ///
    /// ### Properties:
    /// - `id`: Уникальный идентификатор процедуры.
    /// - `price`: Цена процедуры.
    /// - `duration`: Продолжительность процедуры в минутах.
    /// - `service`: Краткие данные о связанной услуге.
    struct Partial: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
        public var price: Price
        public var duration: Int
        public var description: String?
        public var alias: String?
        public var procedures: [Procedure.Responses.Partial]
        
        public init(
            id: UUID,
            price: Price,
            duration: Int,
            description: String?,
            alias: String?,
            procedures: [Procedure.Responses.Partial]
        ) {
            self.id = id
            self.price = price
            self.duration = duration
            self.description = description
            self.alias = alias
            self.procedures = procedures
        }
    }
}


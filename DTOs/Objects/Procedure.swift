import Foundation

/// Пространство имён для всех Data Transfer Objects (DTO), относящихся к процедурам.
/// Управляет данными, связанными с определенными услугами, предоставляемыми салонами красоты и их сотрудниками.
public enum Procedure {
    /// Пространство имён для параметров запросов, связанных с процедурами.
    public enum Parameters {}
    
    /// Пространство имён для структур ответов, предоставляющих данные о процедурах.
    public enum Responses {}
}

// MARK: - Parameters -

public extension Procedure.Parameters {
    
    /// Параметры запроса для получения списка процедур.
    /// Позволяют фильтровать процедуры по определенным салонам и сотрудникам.
    ///
    /// ### Properties:
    /// - `salons`: Список идентификаторов салонов для фильтрации процедур.
    /// - `employees`: Список идентификаторов сотрудников для фильтрации процедур.
    struct Retrieve: Parametable {
        public var salons: [UUID]?
        public var employees: [UUID]?
    }
    
    /// Параметры, передаваемые в теле запроса при создании новой процедуры.
    /// Требуют указания всех необходимых атрибутов процедуры.
    ///
    /// ### Properties:
    /// - `price`: Цена процедуры.
    /// - `duration`: Продолжительность процедуры в минутах.
    /// - `service`: Идентификатор услуги, к которой относится процедура.
    struct Create: Parametable {
        public var price: Price
        public var duration: Int
        public var service: UUID
    }

    /// Параметры, передаваемые в теле запроса для частичного обновления существующей процедуры.
    /// Позволяют изменить цену и/или продолжительность процедуры.
    ///
    /// ### Properties:
    /// - `price`: Новая цена процедуры (опционально).
    /// - `duration`: Новая продолжительность процедуры в минутах (опционально).
    struct Patch: Parametable {
        public var price: Price?
        public var duration: Int?
    }
}

// MARK: - Responses -

public extension Procedure.Responses {
    
    /// Полная структура ответа, содержащая все данные о процедуре.
    /// Используется для передачи полных деталей о процедуре, включая связанную услугу.
    ///
    /// ### Properties:
    /// - `id`: Уникальный идентификатор процедуры.
    /// - `price`: Цена процедуры.
    /// - `duration`: Продолжительность процедуры в минутах.
    /// - `service`: Полные данные о связанной услуге.
    struct Full: Responsable, Identifiable {
        public var id: UUID
        public var price: Price
        public var duration: Int
        public var service: Service.Responses.Full
    }
    
    /// Упрощенная структура ответа для процедур.
    /// Может использоваться для передачи краткой информации о процедуре, включая основные данные связанной услуги.
    ///
    /// ### Properties:
    /// - `id`: Уникальный идентификатор процедуры.
    /// - `price`: Цена процедуры.
    /// - `duration`: Продолжительность процедуры в минутах.
    /// - `service`: Краткие данные о связанной услуге.
    struct Partial: Responsable, Identifiable {
        public var id: UUID
        public var price: Price
        public var duration: Int
        public var service: Service.Responses.Partial
    }
}

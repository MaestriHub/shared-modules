import Foundation

/// Пространство имён для всех Data Transfer Objects (DTO), относящихся к услугам (Procedure).
/// Обеспечивает стандартизированный обмен информацией о процедурах и услугах в системе.
public enum Service {
    /// Пространство имён для параметров запросов, связанных с услугами.
    public enum Parameters {}
    
    /// Пространство имён для структур ответов, предоставляющих данные о услугах.
    public enum Responses {}
}

// MARK: - Parameters -

public extension Service.Parameters {
    
    /// Параметры запроса для получения списка услуг.
    /// Могут включать фильтрацию и сортировку, но в данном примере не определены.
    struct Retrieve: Parametable {
        // Здесь могут быть определены фильтры для запроса списка услуг, если это необходимо.
    }
    
    /// Параметры, передаваемые в теле запроса при создании новой услуги.
    /// Требуют указания обязательных полей для регистрации услуги в системе.
    ///
    /// ### Properties:
    /// - `title`: Название услуги.
    /// - `description`: Описание услуги, детализирующее предоставляемую процедуру.
    struct Create: Parametable {
        public var title: String
        public var description: String
    }

    /// Параметры, передаваемые в теле запроса для частичного обновления данных об услуге.
    /// Позволяют изменить название и/или описание существующей услуги.
    ///
    /// ### Properties:
    /// - `title`: Новое название услуги (опционально).
    /// - `description`: Новое описание услуги (опционально).
    struct Patch: Parametable {
        public var title: String?
        public var description: String?
    }
}

// MARK: - Responses -

public extension Service.Responses {
    
    /// Полная структура ответа, содержащая все данные об услуге.
    /// Используется для передачи детальной информации о конкретной услуге.
    ///
    /// ### Properties:
    /// - `id`: Уникальный идентификатор услуги.
    /// - `title`: Название услуги.
    /// - `description`: Подробное описание услуги.
    struct Full: Responsable, Identifiable {
        public var id: UUID
        public var title: String
        public var description: String
    }
    
    /// Упрощенная структура ответа для услуг.
    /// Может использоваться для передачи краткой информации об услугах в списках или при кратком обзоре.
    ///
    /// ### Properties:
    /// - `id`: Уникальный идентификатор услуги.
    /// - `title`: Название услуги.
    /// - `description`: Описание услуги, содержащее основные характеристики.
    struct Partial: Responsable, Identifiable {
        public var id: UUID
        public var title: String
        public var description: String
    }
}


import Foundation

/// Пространство имен `Service` содержит типы данных для взаимодействия с информацией о салонах красоты.
///
/// Включает параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обработки данных о салонах в системе.
public enum Service {
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Service.Parameters {
    
    /// Параметры запроса для получения списка услуг.
    /// Могут включать фильтрацию и сортировку, но в данном примере не определены.
    struct Retrieve: Parametable {
        public let value: String?
        public let page: Int
        public let per: Int
        
        public init(
            value: String?,
            page: Int,
            per: Int
        ) {
            self.value = value
            self.page = page
            self.per = per
        }
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
        
        public init(
            title: String,
            description: String
        ) {
            self.title = title
            self.description = description
        }
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
        
        public init(
            title: String? = nil,
            description: String? = nil
        ) {
            self.title = title
            self.description = description
        }
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
    struct Full: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
        public var title: String
        public var description: String
        
        public init(
            id: UUID,
            title: String,
            description: String
        ) {
            self.id = id
            self.title = title
            self.description = description
        }
    }
    
    /// Упрощенная структура ответа для услуг.
    /// Может использоваться для передачи краткой информации об услугах в списках или при кратком обзоре.
    ///
    /// ### Properties:
    /// - `id`: Уникальный идентификатор услуги.
    /// - `title`: Название услуги.
    /// - `description`: Описание услуги, содержащее основные характеристики.
    struct Partial: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
        public var title: String
        public var description: String
        
        public init(
            id: UUID,
            title: String,
            description: String
        ) {
            self.id = id
            self.title = title
            self.description = description
        }
    }
}


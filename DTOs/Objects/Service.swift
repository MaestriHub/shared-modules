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
        public let salons: [UUID]?
        public let employees: [UUID]?
        public let value: String?
        public let page: Int
        public let per: Int
        
        public init(
            salons: [UUID]? = nil,
            employees: [UUID]? = nil,
            value: String?,
            page: Int,
            per: Int
        ) {
            self.salons = salons
            self.employees = employees
            self.value = value
            self.page = page
            self.per = per
        }
    }
    
    struct RetrieveFull: Parametable {
        public let salon: UUID?
        
        public init(
            salon: UUID? = nil
        ) {
            self.salon = salon
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
        public var category: ServiceCategory
        
        public init(
            title: String,
            description: String,
            category: ServiceCategory
        ) {
            self.title = title
            self.description = description
            self.category = category
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
        public var category: ServiceCategory?
        
        public init(
            title: String? = nil,
            description: String? = nil,
            category: ServiceCategory? = nil
        ) {
            self.title = title
            self.description = description
            self.category = category
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
        public var category: ServiceCategory
        public var procedures: [Procedure.Responses.Partial]
        
        public init(
            id: UUID,
            title: String,
            description: String,
            category: ServiceCategory,
            procedures: [Procedure.Responses.Partial]
        ) {
            self.id = id
            self.title = title
            self.description = description
            self.category = category
            self.procedures = procedures
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
        public var category: ServiceCategory
        
        public init(
            id: UUID,
            title: String,
            description: String,
            category: ServiceCategory
        ) {
            self.id = id
            self.title = title
            self.description = description
            self.category = category
        }
    }
}


import Foundation

/// Пространство имен `Customer` содержит типы данных для работы с информацией о клиентах.
///
/// В него входят параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обмена данными между клиентом и сервером в контексте клиентских данных.
public enum Customer {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Customer.Parameters {
    
    
    /// Параметры, используемые при создании профиля клиента.
    ///
    /// ### Properties:
    ///  - contacts: Массив контактов через которые ему будет удобное связываться с мастером.
    struct Create: Parametable {
        public var contacts: [Contact.Parameters.Create]
        
        public init(
            contacts: [Contact.Parameters.Create]
        ) {
            self.contacts = contacts
        }
    }
    
    /// Параметры запроса для получения списка клиентов.
    /// Позволяют фильтровать клиентов по определенным салонам.
    ///
    /// ### Properties:
    /// - `employees`: Список идентификаторов employees для фильтрации клиентов.
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
    
    /// Параметры для частичного обновления профиля пользователя.
    ///
    /// ### Properties:
    ///  - contacts: Контактная информация Customer, для связи с ним
    struct Patch: Parametable {
        public var contacts: [Contact.Parameters.Create]
        
        public init(
            contacts: [Contact.Parameters.Create]
        ) {
            self.contacts = contacts
        }
    }
}

//MARK: - Responses -

public extension Customer.Responses {
    
    /// `Partial` предоставляет сокращенную информацию о клиенте, используемую для списков и обзоров.
    ///
    /// ### Properties:
    /// - id: `UUID` - уникальный идентификатор клиента.
    /// - name: `String` - имя клиента.
    /// - avatar: `URL?` - URL аватара клиента, может быть `nil`, если аватар отсутствует.
    /// - contacts: `[Contact.Responses.Full]` - массив полных контактных данных клиента.
    struct Partial: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
        public var name: String
        public var avatar: URL?
        public var contacts: [Contact.Responses.Full]
        
        public init(
            id: UUID,
            name: String,
            avatar: URL? = nil,
            contacts: [Contact.Responses.Full]
        ) {
            self.id = id
            self.name = name
            self.avatar = avatar
            self.contacts = contacts
        }
    }
}

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
    
    /// Параметры запроса для получения списка клиентов.
    /// Позволяют фильтровать клиентов по определенным салонам.
    ///
    /// ### Properties:
    /// - `employees`: Список идентификаторов employees для фильтрации клиентов.
    struct Retrieve: Parametable {
        public let employees: [UUID]?
        
        public init(
            employees: [UUID]? = nil
        ) {
            self.employees = employees
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
    struct Partial: Responsable, Identifiable {
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

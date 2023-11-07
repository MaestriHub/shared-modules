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
    
    /// Параметры `Invite` используются для приглашения пользователя на сервис.
    /// Доступ к этому методу имеют как профессиональные пользователи (Pro), так и обычные пользователи.
    ///
    /// ### Properties:
    /// - name: `String` - имя пользователя, которое будет использоваться в приглашении.
    /// - contact: `Contact.Parameters.Create` - контактные данные пользователя, необходимые для приглашения.
    struct Invite: Responsable {
        public let name: String
        public let contact: Contact.Parameters.Create
        
        public init(
            name: String,
            contact: Contact.Parameters.Create
        ) {
            self.name = name
            self.contact = contact
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

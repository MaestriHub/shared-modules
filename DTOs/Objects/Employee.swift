import Foundation

/// Пространство имен `Employee` содержит типы данных для работы с информацией о сотрудниках.
///
/// Включает в себя параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// которые применяются для обмена данными о сотрудниках между клиентскими приложениями и сервером.
public enum Employee {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Employee.Parameters {
    
    /// Параметры запроса для получения списка сотрудников.
    /// Позволяют фильтровать сотрудников по определенным салонам.
    ///
    /// ### Properties:
    /// - `salons`: Список идентификаторов салонов для фильтрации сотрудников.
    struct Retrieve: Parametable {
        public let salons: [UUID]?
        
        public init(
            salons: [UUID]? = nil
        ) {
            self.salons = salons
        }
    }
}

//MARK: - Responses -

public extension Employee.Responses {
    
    /// `Full` возвращает полный набор информации о сотруднике, предназначенный для подробного просмотра.
    ///
    /// ### Properties:
    /// - id: `UUID` - уникальный идентификатор сотрудника.
    /// - nickname: `String` - псевдоним сотрудника.
    /// - avatar: `URL?` - URL-адрес аватара сотрудника, может быть `nil`, если аватар отсутствует.
    /// - contacts: `[Contact.Responses.Full]` - полный список контактной информации сотрудника.
    /// - procedures: `[Procedure.Responses.Partial]?` - опциональный список процедур, которые сотрудник выполняет.
    struct Full: Responsable, Identifiable {
        public var id: UUID
        public var nickname: String
        public var avatar: URL?
        public var contacts: [Contact.Responses.Full]
        
        public var procedures: [Procedure.Responses.Partial]?
        
        public init(
            id: UUID,
            nickname: String,
            avatar: URL? = nil,
            contacts: [Contact.Responses.Full],
            procedures: [Procedure.Responses.Partial]? = nil
        ) {
            self.id = id
            self.nickname = nickname
            self.avatar = avatar
            self.contacts = contacts
            self.procedures = procedures
        }
    }
    
    /// `Partial` возвращает упрощенную информацию о сотруднике для использования в списках или кратких обзорах.
    ///
    /// ### Properties:
    /// - id: `UUID` - уникальный идентификатор сотрудника.
    /// - name: `String` - имя сотрудника.
    /// - contacts: `[Contact.Responses.Full]` - полный список контактной информации сотрудника.
    struct Partial: Responsable, Identifiable {
        public var id: UUID
        public var name: String
        public var contacts: [Contact.Responses.Full]
        
        public init(
            id: UUID,
            name: String,
            contacts: [Contact.Responses.Full]
        ) {
            self.id = id
            self.name = name
            self.contacts = contacts
        }
    }
}

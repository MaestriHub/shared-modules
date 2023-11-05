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
    
    /// Параметры `Invite` используются для отправки приглашения сотрудникам присоединиться к сервису.
    /// Доступ к этому функционалу предоставляется как профессиональным пользователям (Pro), так и обычным пользователям.
    ///
    /// ### Properties:
    /// - name: `String` - имя сотрудника, которое будет использоваться в приглашении.
    /// - contact: `Contact.Parameters.Create` - контактные данные сотрудника, необходимые для отправки приглашения.
    struct Invite: Responsable {
        public var name: String
        public var contact: Contact.Parameters.Create
    }
}

//MARK: - Responses -

public extension Employee.Responses {
    
    /// `Full` возвращает полный набор информации о сотруднике, предназначенный для подробного просмотра.
    ///
    /// ### Properties:
    /// - id: `UUID` - уникальный идентификатор сотрудника.
    /// - nickname: `String` - псевдоним сотрудника.
    /// - avatar: `String?` - URL-адрес аватара сотрудника, может быть `nil`, если аватар отсутствует.
    /// - contacts: `[Contact.Responses.Full]` - полный список контактной информации сотрудника.
    /// - procedures: `[Procedure.Responses.Partial]?` - опциональный список процедур, которые сотрудник выполняет.
    struct Full: Responsable, Identifiable {
        public var id: UUID
        public var nickname: String
        public var avatar: String?
        public var contacts: [Contact.Responses.Full]
        
        public var procedures: [Procedure.Responses.Partial]?
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
    }
}

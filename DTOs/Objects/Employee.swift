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
        public let salonsId: [UUID]
        
        public init(
            salonsId: [UUID]
        ) {
            self.salonsId = salonsId
        }
    }
    
    /// Параметры, передаваемые в теле запроса при приглашение нового сотрудника.
    ///
    /// ### Properties:
    /// - `salondId`: Идентификатор салона
    struct Invite: Parametable {
        public var salondId: UUID
        public var contacts: [Contact.Parameters.Create]
        
        public init(
            salondId: UUID,
            contacts: [Contact.Parameters.Create]
        ) {
            self.salondId = salondId
            self.contacts = contacts
        }
    }
    
    /// Параметры для частичного обновления Employee.
    ///
    /// ### Properties:
    ///  - contacts: Контактная информация Employee, для связи с ним
    /// - timetable: Расписание времени работы
    struct Patch: Parametable {
        public var roleSet: SalonRoleSet?
        public var contacts: [Contact.Parameters.Create]?
        public var timetable: Timetable.Parameters.Create?
        
        public init(
            roleSet: SalonRoleSet?,
            contacts: [Contact.Parameters.Create]?,
            timetable: Timetable.Parameters.Create?
        ) {
            self.roleSet = roleSet
            self.contacts = contacts
            self.timetable = timetable
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
    struct Full: Responsable, Identifiable, Equatable {
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
    struct Partial: Responsable, Identifiable, Equatable {
        public var id: UUID
        public var name: String
        public var contacts: [Contact.Responses.Full]
        public var url: URL?
        
        public init(
            id: UUID,
            name: String,
            contacts: [Contact.Responses.Full],
            url: URL?
        ) {
            self.id = id
            self.name = name
            self.contacts = contacts
            self.url = url
        }
    }
}

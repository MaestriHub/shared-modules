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
        public var positionId: UUID
        public var contacts: [Contact.Parameters.Create]
        public var timetable: Schedule.Week?
        public var description: String?
        
        public init(
            salondId: UUID,
            positionId: UUID,
            contacts: [Contact.Parameters.Create],
            timetable: Schedule.Week?,
            description: String?
        ) {
            self.salondId = salondId
            self.positionId = positionId
            self.contacts = contacts
            self.timetable = timetable
            self.description = description
        }
    }
    
    /// Параметры для частичного обновления Employee.
    ///
    /// ### Properties:
    struct Patch: Parametable {
        public var positionId: UUID?
        
        public init(
            positionId: UUID
        ) {
            self.positionId = positionId
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
    /// - position: Position.Responses.Full - полная информация о дожности
    /// - procedures: `[Procedure.Responses.Partial]?` - опциональный список процедур, которые сотрудник выполняет.
    struct Full: Responsable, Identifiable, Equatable {
        public var id: UUID
        public var user: ProfessionalEmployee
        public var description: String?
        public var canEdit: Bool = false
        public var contacts: [Contact.Responses.Full]
        public var salonId: UUID
        public var position: Position.Responses.Full
        
        public init(
            id: UUID,
            user: ProfessionalEmployee,
            description: String? = nil,
            canEdit: Bool,
            contacts: [Contact.Responses.Full],
            salonId: UUID,
            position: Position.Responses.Full
        ) {
            self.id = id
            self.user = user
            self.description = description
            self.canEdit = canEdit
            self.contacts = contacts
            self.salonId = salonId
            self.position = position
        }
    }
    
    /// `Partial` возвращает упрощенную информацию о сотруднике для использования в списках или кратких обзорах.
    ///
    /// ### Properties:
    /// - id: `UUID` - уникальный идентификатор сотрудника.
    /// - name: `String` - имя сотрудника.
    /// - contacts: `[Contact.Responses.Full]` - полный список контактной информации сотрудника.
    /// - position: Position.Responses.Full - полная информация о дожности.
    struct Partial: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
        public var user: User.Responses.Partial?
        public var contacts: [Contact.Responses.Full]
        public var position: Position.Responses.Partial
        
        public init(
            id: UUID,
            user: User.Responses.Partial?,
            contacts: [Contact.Responses.Full],
            position: Position.Responses.Partial
        ) {
            self.id = id
            self.user = user
            self.contacts = contacts
            self.position = position
        }
    }
}

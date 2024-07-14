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
        public var jobPostId: UUID
        public var contacts: [Contact.Parameters.Create]
        public var timetable: Timetable.Week?
        public var description: String?
        
        public init(
            salondId: UUID,
            jobPostId: UUID,
            contacts: [Contact.Parameters.Create],
            timetable: Timetable.Week?,
            description: String?
        ) {
            self.salondId = salondId
            self.jobPostId = jobPostId
            self.contacts = contacts
            self.timetable = timetable
            self.description = description
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
        public var timetable: Timetable.Week?
        public var description: String?
        
        public init(
            roleSet: SalonRoleSet?,
            contacts: [Contact.Parameters.Create]?,
            timetable: Timetable.Week?,
            description: String?
        ) {
            self.roleSet = roleSet
            self.contacts = contacts
            self.timetable = timetable
            self.description = description
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
        public var user: ProfessionalEmployee
        public var description: String?
        public var canEdit: Bool = false
        public var contacts: [Contact.Responses.Full]
        public var timetable: Timetable.Week
        public var salonId: UUID
        
        public var procedures: [Procedure.Responses.Partial]?
        
        public init(
            id: UUID,
            user: ProfessionalEmployee,
            description: String? = nil,
            canEdit: Bool,
            contacts: [Contact.Responses.Full],
            timetable: Timetable.Week,
            salonId: UUID,
            procedures: [Procedure.Responses.Partial]? = nil
        ) {
            self.id = id
            self.user = user
            self.description = description
            self.canEdit = canEdit
            self.contacts = contacts
            self.timetable = timetable
            self.salonId = salonId
            self.procedures = procedures
        }
    }
    
    /// `Partial` возвращает упрощенную информацию о сотруднике для использования в списках или кратких обзорах.
    ///
    /// ### Properties:
    /// - id: `UUID` - уникальный идентификатор сотрудника.
    /// - name: `String` - имя сотрудника.
    /// - contacts: `[Contact.Responses.Full]` - полный список контактной информации сотрудника.
    struct Partial: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
        public var name: String
        public var avatar: URL?
        public var contacts: [Contact.Responses.Full]
        
        public init(
            id: UUID,
            name: String,
            avatar: URL?,
            contacts: [Contact.Responses.Full]
        ) {
            self.id = id
            self.name = name
            self.avatar = avatar
            self.contacts = contacts
        }
    }
}

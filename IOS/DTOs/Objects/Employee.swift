import Foundation

public enum Employee {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Employee.Parameters {
    
    struct Retrieve: Parametable {
        public let salonsId: [UUID]
        
        public init(
            salonsId: [UUID]
        ) {
            self.salonsId = salonsId
        }
    }
    
    struct Invite: Parametable {
        public var nickname: String?
        public var salonId: UUID
        public var positionId: UUID
        public let contactValue: String
        public let contactType: ContactType
        public var timetable: Timetable.Parameters.Create.Pattern?
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
    struct Full: Responsable {
        public var id: UUID
        public var user: ProfessionalEmployee
        public var description: String?
        public var canEdit: Bool = false
        public var contacts: [Contact.Shared.PrimaryContact]
        public var salonId: UUID
        public var position: Position.Responses.Full
        
        public init(
            id: UUID,
            user: ProfessionalEmployee,
            description: String? = nil,
            canEdit: Bool,
            contacts: [Contact.Shared.PrimaryContact],
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
    struct Partial: Responsable {
        public var id: UUID
        public var nickname: String
        public var avatar: URL?
        public var contacts: [Contact.Shared.PrimaryContact]
        public var position: Position.Responses.Partial
        
        public init(
            id: UUID,
            nickname: String,
            avatar: URL?,
            contacts: [Contact.Shared.PrimaryContact],
            position: Position.Responses.Partial
        ) {
            self.id = id
            self.nickname = nickname
            self.avatar = avatar
            self.contacts = contacts
            self.position = position
        }
    }
}

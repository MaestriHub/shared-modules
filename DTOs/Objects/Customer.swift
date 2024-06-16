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
    
    struct Registration: Parametable {
        public var contacts: [Contact.Parameters.Create]
        
        public init(contacts: [Contact.Parameters.Create]) {
            self.contacts = contacts
        }
    }
    
    struct Create: Parametable {
        public var salonId: UUID?
        public var alias: String
        public var contacts: [Contact.Parameters.Create]
        
        public init(
            salonId: UUID?,
            alias: String,
            contacts: [Contact.Parameters.Create]
        ) {
            self.salonId = salonId
            self.alias = alias
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

    /// Параметры для того, чтобы принять приглашение в приложение.
    ///
    /// ### Properties:
    ///  - salonName: Название салона для поиска по ИМе
    struct HandleInvite: Parametable {
        public var salonName: UUID

        public init(
            salonName: UUID
        ) {
            self.salonName = salonName
        }
    }
}

//MARK: - Responses -

public extension Customer.Responses {
    
    struct Full: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
        public var user: CustomerUser
        public var alias: String?
        public var contacts: [Contact.Responses.Full]
        
        public init(
            id: UUID,
            user: CustomerUser,
            alias: String?,
            contacts: [Contact.Responses.Full]
        ) {
            self.id = id
            self.user = user
            self.alias = alias
            self.contacts = contacts
        }
    }
    
    struct Partial: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
        public var user: CustomerUser
        public var alias: String?
        public var contacts: [Contact.Responses.Full]
        
        public init(
            id: UUID,
            user: CustomerUser,
            alias: String?,
            contacts: [Contact.Responses.Full]
        ) {
            self.id = id
            self.user = user
            self.alias = alias
            self.contacts = contacts
        }
    }
}

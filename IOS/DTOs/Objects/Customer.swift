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
        public var contact: Contact.Parameters.Create
        
        public init(contact: Contact.Parameters.Create) {
            self.contact = contact
        }
    }
    
    struct Create: Parametable {
        public var salonId: UUID?
        public var alias: String
        public var contact: Contact.Parameters.Create
        
        public init(
            salonId: UUID?,
            alias: String,
            contact: Contact.Parameters.Create
        ) {
            self.salonId = salonId
            self.alias = alias
            self.contact = contact
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

    /// Параметры для того, чтобы принять приглашение в приложение.
    ///
    /// ### Properties:
    ///  - contact: value Контакта для верификации
    struct HandleInvite: Parametable {
        public var contact: String?

        public init(
            contact: String? = nil
        ) {
            self.contact = contact
        }
    }
}

//MARK: - Responses -

public extension Customer.Responses {
    
    struct Full: Responsable {
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
    
    struct Partial: Responsable {
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

    struct Verify: Responsable {
        public var contacts: [Contact.Responses.Full]

        public init(
            contacts: [Contact.Responses.Full]
        ) {
            self.contacts = contacts
        }        
    }
}

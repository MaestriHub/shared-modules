import Foundation

/// Пространство имен `User` содержит типы данных для взаимодействия с информацией о салонах красоты.
///
/// Включает параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обработки данных о салонах в системе.
public enum User {
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension User.Parameters {
    
    /// Параметры, используемые при переключение профиля.
    ///
    /// ### Properties:
    struct Switch: Parametable {
        
        public var role: UserRoleSet

        public init(
            role: UserRoleSet
        ) {
            self.role = role
        }
    }
    
    /// Параметры, используемые при создании профиля профессионала.
    ///
    /// ### Properties:
    struct CreateProfessional: Parametable {

        public init() {}
    }
    
    /// Параметры, используемые при создании профиля клиента.
    ///
    /// ### Properties:
    ///  - contacts: Массив контактов через которые ему будет удобное связываться с мастером.
    struct CreateCustomer: Parametable {
        public var contacts: [Contact.Parameters.Create]
        
        public init(
            contacts: [Contact.Parameters.Create]
        ) {
            self.contacts = contacts
        }
    }
    
    /// Параметры для частичного обновления профиля пользователя.
    ///
    /// ### Properties:
    ///   - nickname: Новый псевдоним пользователя, если требуется обновление.
    ///  - avatar: Новая ссылка на изображение аватара пользователя, если требуется обновление.
    ///  - contact: Контактная информация пользователя, для востонавления данных и так далее
    struct Patch: Parametable {
        public var nickname: String?
        public var avatar: URL?
        public var contact: Contact.Parameters.Create?
        
        public init(
            nickname: String? = nil,
            avatar: URL? = nil
        ) {
            self.nickname = nickname
            self.avatar = avatar
        }
    }
}

// MARK: - Responses -

public extension User.Responses {
    
    /// Полные данные о пользователе для отображения на странице профиля.
    ///
    /// ### Properties:
    ///   - id: Уникальный идентификатор пользователя в системе.
    ///  - avatar: Ссылка на изображение аватара пользователя, может быть не указана.
    ///  - nickname: Отображаемое имя пользователя.
    ///  - contact: Полная контактная информация, ассоциированная с профилем пользователя.
    ///  - options: Роли пользователя, определенные в системе.
    struct Full: Responsable, Identifiable, Equatable {
        public var id: UUID
        public var avatar: URL?
        public var nickname: String
        public var contact: Contact.Responses.Full?
        public var options: UserRoleSet
        
        public init(
            id: UUID,
            avatar: URL? = nil,
            nickname: String,
            contact: Contact.Responses.Full?,
            options: UserRoleSet
        ) {
            self.id = id
            self.avatar = avatar
            self.nickname = nickname
            self.contact = contact
            self.options = options
        }
    }
    
    /// Краткие данные о пользователе для отображения на главной странице.
    ///
    /// ### Properties:
    ///   - id: Уникальный идентификатор пользователя в системе.
    ///  - avatar: Ссылка на изображение аватара пользователя, может быть не указана.
    ///  - nickname: Псевдоним пользователя для представления в пользовательском интерфейсе.
    struct Partial: Responsable, Identifiable, Equatable {
        public var id: UUID
        public var avatar: URL?
        public var nickname: String
        
        public init(
            id: UUID,
            avatar: URL? = nil,
            nickname: String
        ) {
            self.id = id
            self.avatar = avatar
            self.nickname = nickname
        }
    }
}

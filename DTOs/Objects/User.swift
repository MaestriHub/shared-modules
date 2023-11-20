import Foundation

/// Пространство имен `User` содержит типы данных для взаимодействия с информацией о салонах красоты.
///
/// Включает параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обработки данных о салонах в системе.
public enum User {
    public enum Parameters {}
    public enum Responses {}
}

/// Набор опций, представляющих различные роли пользователя в системе.
///
/// Поддерживает:
/// - `customer` -  Опция, представляющая пользователя как клиента.
/// - `professional` -  Опция, представляющая пользователя как профессионала.
public struct UserRole: OptionSet, Codable {
    
    public static let customer = UserRole(rawValue: 1 << 0)
    public static let professional = UserRole(rawValue: 1 << 1)
    
    public var rawValue: Int
    
    /// Инициализирует экземпляр с указанным сырым значением.
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

// MARK: - Parameters -

public extension User.Parameters {
    
    /// Параметры, используемые при создании профиля профессионала.
    ///
    /// ### Properties:
    ///   - nickname: Псевдоним пользователя, используемый для взаимодействия в приложении.
    ///  - avatar: Ссылка на изображение аватара пользователя.
    ///  - contact: Контактная информация пользователя, введенная при регистрации.
    struct CreateProfessional: Parametable {
        public var nickname: String
        public var avatar: URL
        public var contact: Contact.Parameters.Create
        
        public init(
            nickname: String,
            avatar: URL,
            contact: Contact.Parameters.Create
        ) {
            self.nickname = nickname
            self.avatar = avatar
            self.contact = contact
        }
    }
    
    /// Параметры, используемые при создании профиля клиента.
    ///
    /// ### Properties:
    ///   - nickname: Псевдоним пользователя, используемый для взаимодействия в приложении.
    ///  - avatar: Ссылка на изображение аватара пользователя.
    ///  - contact: Массив контактной информации пользователя.
    struct CreateCustomer: Parametable {
        public var nickname: String
        public var avatar: URL
        public var contact: [Contact.Parameters.Create]
        
        public init(
            nickname: String,
            avatar: URL,
            contact: [Contact.Parameters.Create]
        ) {
            self.nickname = nickname
            self.avatar = avatar
            self.contact = contact
        }
    }
    
    /// Параметры для частичного обновления профиля пользователя.
    ///
    /// ### Properties:
    ///   - nickname: Новый псевдоним пользователя, если требуется обновление.
    ///  - avatar: Новая ссылка на изображение аватара пользователя, если требуется обновление.
    struct Patch: Parametable {
        public var nickname: String?
        public var avatar: URL?
        
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
    struct Full: Responsable, Identifiable {
        public var id: UUID
        public var avatar: URL?
        public var nickname: String
        public var contact: Contact.Responses.Full
        public var options: UserRole
        
        public init(
            id: UUID,
            avatar: URL? = nil,
            nickname: String,
            contact: Contact.Responses.Full,
            options: UserRole
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
    struct Partial: Responsable, Identifiable {
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
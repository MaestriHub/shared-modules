import Foundation

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

/// Пространство имен для всех Data Transfer Objects (DTO), связанных с пользователями.
public enum User {
    /// Вложенное перечисление для параметров запросов.
    public enum Parameters {}
    /// Вложенное перечисление для ответов запросов.
    public enum Responses {}
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
        public var avatar: String
        public var contact: Contact.Parameters.Create
    }
    
    /// Параметры, используемые при создании профиля клиента.
    ///
    /// ### Properties:
    ///   - nickname: Псевдоним пользователя, используемый для взаимодействия в приложении.
    ///  - avatar: Ссылка на изображение аватара пользователя.
    ///  - contact: Массив контактной информации пользователя.
    struct CreateCustomer: Parametable {
        public var nickname: String
        public var avatar: String
        public var contact: [Contact.Parameters.Create]
    }
    
    /// Параметры для частичного обновления профиля пользователя.
    ///
    /// ### Properties:
    ///   - nickname: Новый псевдоним пользователя, если требуется обновление.
    ///  - avatar: Новая ссылка на изображение аватара пользователя, если требуется обновление.
    struct Patch: Parametable {
        public var nickname: String?
        public var avatar: URL?
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
        public var avatar: String?
        public var nickname: String
        public var contact: Contact.Responses.Full
        public var options: UserRole
    }
    
    /// Краткие данные о пользователе для отображения на главной странице.
    ///
    /// ### Properties:
    ///   - id: Уникальный идентификатор пользователя в системе.
    ///  - avatar: Ссылка на изображение аватара пользователя, может быть не указана.
    ///  - nickname: Псевдоним пользователя для представления в пользовательском интерфейсе.
    struct Partial: Responsable, Identifiable {
        public var id: UUID
        public var avatar: String?
        public var nickname: String
    }
}

import Foundation

/// Пространство имен `Auth` содержит типы данных для работы с записями на прием.
///
/// В него входят как параметры для запросов (`Parameters`), так и модели ответов (`Responses`),
/// которые используются для сериализации данных, отправляемых и получаемых от API.
public enum Auth {
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Auth.Parameters {
    
    /// Параметры для аутентификации через Apple.
    /// Структура `AppleToken` содержит данные, полученные от Apple при аутентификации пользователя.
    ///
    /// ### Properties:
    ///   - token: Токен, выданный Apple.
    ///  - firstName: Имя пользователя, полученное от Apple, если доступно.
    ///  - lastName: Фамилия пользователя, полученное от Apple, если доступно.
    ///  - email: Электронная почта пользователя, если доступна.
    ///  - emailVerified: Флаг, указывающий, подтверждён ли email.
    struct AppleToken: Parametable {
        public var token: String
        public var firstName: String?
        public var lastName: String?
        public var email: String?
        public var emailVerified: Bool?
        
        public init(
            token: String,
            firstName: String?,
            lastName: String?,
            email: String? = nil,
            emailVerified: Bool = false
        ) {
            self.token = token
            self.firstName = firstName
            self.lastName = lastName
            self.email = email
            self.emailVerified = emailVerified
        }
    }
    
    /// Параметры для аутентификации через Google.
    /// Структура `GoogleToken` содержит данные, полученные от Google при аутентификации пользователя.
    ///
    /// ### Properties:
    ///   - token: Токен, выданный Google.
    ///  - firstName: Имя пользователя, полученное от Google, если доступно.
    ///  - lastName: Фамилия пользователя, полученное от Google, если доступно.
    struct GoogleToken: Parametable {
        public var token: String
        public var firstName: String?
        public var lastName: String?
        
        public init(
            token: String,
            firstName: String?,
            lastName: String?
        ) {
            self.token = token
            self.firstName = firstName
            self.lastName = lastName
        }
    }
}

// MARK: - Responses -

public extension Auth.Responses {
    
    /// Полный ответ аутентификации.
    /// Структура `Full` предоставляет токен аутентификации и полную информацию о пользователе.
    ///
    /// ### Properties:
    ///   - accessToken: Токен аутентификации.
    ///  - refreshToken: Токен сессии.
    ///  - user: Полная информация о пользователе в формате `User.Responses.Full`.
    struct Full: Responsable {
        public let accessToken: Token
        public let refreshToken: Token
        public let user: User.Responses.Full
        
        public init(
            accessToken: Token,
            refreshToken: Token,
            user: User.Responses.Full
        ) {
            self.accessToken = accessToken
            self.refreshToken = refreshToken
            self.user = user
        }
    }
    
    /// Частичный ответ аутентификации.
    /// Структура `Partial` предоставляет токен аутентификации без дополнительных данных о пользователе.
    ///
    /// ### Properties:
    ///   - accessToken: Токен аутентификации.
    ///  - refreshToken: Токен сессии.
    struct Partial: Responsable {
        public let accessToken: Token
        public let refreshToken: Token?
        
        public init(
            accessToken: Token,
            refreshToken: Token?
        ) {
            self.accessToken = accessToken
            self.refreshToken = refreshToken
        }
    }
}

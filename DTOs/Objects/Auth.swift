import Foundation

/// Пространство имён для всех DTO (Data Transfer Objects), относящихся к аутентификации.
/// Содержит определения параметров и структур ответов для аутентификационных процессов.
public enum Auth {
    /// Пространство для параметров запросов аутентификации.
    public enum Parameters {}

    /// Пространство для структур ответов аутентификации.
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
        public let token: String
        public let firstName: String?
        public let lastName: String?
        public var email: String?
        public var emailVerified: Bool
    }
    
    /// Параметры для аутентификации через Google.
    /// Структура `GoogleToken` содержит данные, полученные от Google при аутентификации пользователя.
    ///
    /// ### Properties:
    ///   - token: Токен, выданный Google.
    ///  - firstName: Имя пользователя, полученное от Google, если доступно.
    ///  - lastName: Фамилия пользователя, полученное от Google, если доступно.
    struct GoogleToken: Parametable {
        public let token: String
        public let firstName: String?
        public let lastName: String?
    }
}

// MARK: - Responses -

public extension Auth.Responses {
    
    /// Полный ответ аутентификации.
    /// Структура `Full` предоставляет токен аутентификации и полную информацию о пользователе.
    ///
    /// ### Properties:
    ///   - token: Токен аутентификации.
    ///  - user: Полная информация о пользователе в формате `User.Responses.Full`.
    struct Full: Responsable {
        public let token: String
        public let user: User.Responses.Full
    }
    
    /// Частичный ответ аутентификации.
    /// Структура `Partial` предоставляет токен аутентификации без дополнительных данных о пользователе.
    ///
    /// ### Properties:
    ///   - token: Токен аутентификации.
    struct Partial: Responsable {
        public let token: String
    }
}

import Foundation

/// Пространство имён для всех Data Transfer Objects (DTO), относящихся к контактам пользователя.
public enum Contact {
    /// Пространство имён для параметров запросов, связанных с контактами.
    public enum Parameters {}

    /// Пространство имён для структур ответов, связанных с контактами.
    public enum Responses {}
}

/// Перечисление, определяющее поддерживаемые типы контактных данных.
/// - `phone`: Телефонный номер.
/// - `email`: Электронная почта.
/// - `telegram`: Идентификатор Telegram.
/// - `whatsapp`: Идентификатор WhatsApp.
/// - `instagram`: Идентификатор Instagram.
public enum ContactType: String, Codable {
    case phone
    case email
    case telegram
    case whatsapp
    case instagram
}

// MARK: - Parameters -

public extension Contact.Parameters {
    
    /// Параметры для создания контакта.
    /// Включает в себя информацию, необходимую для регистрации нового контактного метода.
    ///
    /// ### Properties:
    /// - `value`: Значение контактного данных, например номер телефона или адрес электронной почты.
    /// - `type`: Тип контактного метода, определенный в ``ContactType``.
    struct Create: Parametable {
        public var value: String
        public var type: ContactType
    }
    
    /// Параметры для верификации контакта.
    /// Используется для подтверждения контактной информации пользователя.
    ///
    /// ### Properties:
    /// - `value`: Значение контактного метода, который необходимо верифицировать.
    struct Verify: Codable {
        public var value: String
    }
}

// MARK: - Responses -

public extension Contact.Responses {
    
    /// Полная информация о контакте.
    /// Возвращает данные контакта, включая его идентификационный номер и статус верификации.
    ///
    /// ### Properties:
    /// - `id`: Уникальный идентификатор контакта.
    /// - `value`: Значение контактного метода.
    /// - `isVerify`: Статус верификации контакта.
    /// - `type`: Тип контактного метода, определенный в ``ContactType``.
    struct Full: Responsable, Identifiable {
        public var id: UUID
        public var value: String
        public var isVerify: Bool
        public var type: ContactType
    }
}


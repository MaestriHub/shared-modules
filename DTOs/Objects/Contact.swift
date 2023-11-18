import Foundation

/// Пространство имен `Contact` содержит типы данных для работы с записями на прием.
///
/// В него входят как параметры для запросов (`Parameters`), так и модели ответов (`Responses`),
/// которые используются для сериализации данных, отправляемых и получаемых от API.
public enum Contact {
    public enum Parameters {}
    public enum Responses {}
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
        public let value: String
        public let type: ContactType
        public let isVerify: Bool
        
        public init(
            value: String,
            type: ContactType,
            isVerify: Bool
        ) {
            self.value = value
            self.type = type
            self.isVerify = isVerify
        }
    }
    
    /// Параметры для верификации контакта.
    /// Используется для подтверждения контактной информации пользователя.
    ///
    /// ### Properties:
    /// - `value`: Значение контактного метода, который необходимо верифицировать.
    struct Verify: Codable {
        public let value: String
        
        public init(value: String) {
            self.value = value
        }
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
        
        public init(
            id: UUID,
            value: String,
            isVerify: Bool,
            type: ContactType
        ) {
            self.id = id
            self.value = value
            self.isVerify = isVerify
            self.type = type
        }
    }
}


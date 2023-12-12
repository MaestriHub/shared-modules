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
    
    /// Параметры `SendCode` используются для отправки верификационного кода на значение контакта.
    ///
    /// ### Properties:
    /// - type: `ContactType` - тип контакта из списка возможных значений `[phone, email, telegram, whatsapp, instagram]`
    /// - value: `String` - значение контакта
    struct SendCode: Parametable {
        public let type: ContactType
        public let value: String
        
        public init(
            type: ContactType,
            value: String
        ) {
            self.type = type
            self.value = value
        }
    }
    
    /// Параметры `SendCode` используются для отправки верификационного кода на значение контакта.
    ///
    /// ### Properties:
    /// - code: `String` - код отправленный ранее на значение контакта
    struct Verify: Parametable {
        public let code: String
        
        public init(code: String) {
            self.code = code
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
    
    /// `Send` возвращает информацию об отправке верификацонного кода на контакт пользователя
    ///
    /// ### Properties:
    /// - redirectUrl: `String` - ссылка, куда нужно перенаправить пользователя, чтобы получить код при необходимости
    struct Send: Responsable {
        public let redirectUrl: String?
        
        public init(redirectUrl: String?) {
            self.redirectUrl = redirectUrl
        }
    }
    
    /// `Verify` возвращает информацию о том, что контакт был верифицирован
    ///
    /// ### Properties:
    /// - isVeried: `Bool` - поле, обозначающее что контакт верифицирован
    struct Verify: Responsable {
        public let isVerified: Bool
        
        public init(isVerified: Bool) {
            self.isVerified = isVerified
        }
    }
}


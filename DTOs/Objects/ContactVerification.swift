import Foundation

/// Пространство имен `ContactVerification` содержит типы данных для работы с информацией о сотрудниках.
///
/// Включает в себя параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// которые применяются для обмена данными о сотрудниках между клиентскими приложениями и сервером.
public enum ContactVerification {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension ContactVerification.Parameters {
    
    /// Параметры `SendCode` используются для отправки верификационного кода на значение контакта.
    ///
    /// ### Properties:
    /// - type: `ContactType` - тип контакта из списка возможных значений `[phone, email, telegram, whatsapp, instagram]`
    /// - value: `String` - значение контакта
    struct SendCode: Parametable {
        public let type: ContactType
        public let value: String
        
        public init(type: ContactType, value: String) {
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

//MARK: - Responses -

public extension ContactVerification.Responses {
    
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
        public let isVeried: Bool
        
        public init(isVeried: Bool) {
            self.isVeried = isVeried
        }
    }
}

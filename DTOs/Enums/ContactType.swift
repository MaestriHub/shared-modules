import Foundation

/// Перечисление, определяющее поддерживаемые типы контактных данных.
/// - `phone`: Телефонный номер.
/// - `message`: Телефонный номер, возможность отправлять сообщения внутри Maestri?
/// - `email`: Электронная почта.
/// - `telegram`: Идентификатор Telegram.
/// - `whatsapp`: Идентификатор WhatsApp.
/// - `instagram`: Идентификатор Instagram.
public enum ContactType: String, Codable, CaseIterable, Hashable, Equatable {
    case phone
    case email
    case telegram
    case whatsapp
    case instagram
    case message
}

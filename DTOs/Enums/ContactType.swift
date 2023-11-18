import Foundation

/// Перечисление, определяющее поддерживаемые типы контактных данных.
/// - `phone`: Телефонный номер.
/// - `email`: Электронная почта.
/// - `telegram`: Идентификатор Telegram.
/// - `whatsapp`: Идентификатор WhatsApp.
/// - `instagram`: Идентификатор Instagram.
public enum ContactType: String, Codable, CaseIterable {
    case phone
    case email
    case telegram
    case whatsapp
    case instagram
}

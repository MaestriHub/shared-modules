import Foundation

/// Перечисление, определяющее поддерживаемые типы контактных данных.
/// - `phone`: Телефонный номер.
/// - `email`: Электронная почта.
/// - `telegram`: Идентификатор Telegram.
/// - `instagram`: Идентификатор Instagram.
public enum ContactType: String, Codable, CaseIterable, Hashable, Equatable {
    case phone
    case email
    case telegram
    case instagram
}


public enum ConfiguratedContactType: Codable {
    case phone(Set<PhoneTypes>)
    case email
    case instagram
    case telegram
}

public enum PhoneTypes: String, Codable, CaseIterable, Hashable, Equatable {
    case whatsapp
    case message
    case call
}

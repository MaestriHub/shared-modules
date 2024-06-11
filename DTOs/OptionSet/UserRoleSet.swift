import Foundation

/// Набор опций, представляющих различные роли пользователя в системе.
///
/// Поддерживает:
/// - `customer` -  Опция, представляющая пользователя как клиента.
/// - `professional` -  Опция, представляющая пользователя как профессионала.
public struct UserRoleSet: OptionSet, Codable, Hashable {
    
    public static let customer = UserRoleSet(rawValue: 1 << 0)
    public static let professional = UserRoleSet(rawValue: 1 << 1)
    
    public static let all: UserRoleSet = [.customer, .professional]
    
    public var rawValue: Int
    
    /// Инициализирует экземпляр с указанным сырым значением.
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

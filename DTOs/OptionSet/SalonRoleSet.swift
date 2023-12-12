import Foundation

/// Набор опций, представляющих различные роли пользователя в салоне.
///
/// Поддерживает:
/// - `master` -  Опция, представляющая пользователя как мастера.
/// - `admin` -  Опция, представляющая пользователя как admin.
/// - `owner` -  Опция, представляющая пользователя как владелец.
public struct SalonRoleSet: OptionSet, Codable {
    
    public static let master = SalonRoleSet(rawValue: 1 << 0)
    public static let admin = SalonRoleSet(rawValue: 1 << 1)
    public static let owner = SalonRoleSet(rawValue: 1 << 2)
    
    public var rawValue: Int
    
    /// Инициализирует экземпляр с указанным сырым значением.
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

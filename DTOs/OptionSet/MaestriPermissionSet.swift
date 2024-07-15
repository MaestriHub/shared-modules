import Foundation

public struct MaestriPermissionSet: OptionSet, Codable, Hashable {
    
    public static let none = MaestriPermissionSet([])
    public static let service = MaestriPermissionSet(rawValue: 1 << 0) // разрешаем создавать свои сервайсы
    
    public var rawValue: Int
    
    /// Инициализирует экземпляр с указанным сырым значением.
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

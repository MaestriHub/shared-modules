import Foundation

public struct MaetryPermissionSet: OptionSet, Codable, Hashable, Sendable {
    
    public static let none: MaetryPermissionSet = []
    public static let service = MaetryPermissionSet(rawValue: 1 << 0) // разрешаем создавать свои сервайсы
    
    public static let full: MaetryPermissionSet = [.service]
    
    public var rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

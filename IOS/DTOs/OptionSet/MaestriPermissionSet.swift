import Foundation

public struct MaestriPermissionSet: OptionSet, Codable, Hashable, Sendable {
    
    public static let none: MaestriPermissionSet = []
    public static let service = MaestriPermissionSet(rawValue: 1 << 0) // разрешаем создавать свои сервайсы
    
    public static let full: MaestriPermissionSet = [.service]
    
    public var rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

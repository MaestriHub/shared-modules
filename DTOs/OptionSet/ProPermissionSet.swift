import Foundation

public struct ProPermissionSet: OptionSet, Codable, Hashable {
    
    public static let none = ProPermissionSet([])
    public static let service = ProPermissionSet(rawValue: 1 << 0)
    
    public var rawValue: Int
    
    /// Инициализирует экземпляр с указанным сырым значением.
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

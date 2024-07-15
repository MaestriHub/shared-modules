import Foundation

public struct PermissionSet: OptionSet, Codable, Hashable {
    
    public static let none = PermissionSet(rawValue: 1 << 0)
    public static let appointments = PermissionSet(rawValue: 1 << 1)
    public static let statistic = PermissionSet(rawValue: 1 << 2)
    public static let employee = PermissionSet(rawValue: 1 << 3)
    public static let timetable = PermissionSet(rawValue: 1 << 4)
    public static let notifications = PermissionSet(rawValue: 1 << 5)
    public static let salon = PermissionSet(rawValue: 1 << 6)
    public static let operations = PermissionSet(rawValue: 1 << 7)
    public static let procedure = PermissionSet(rawValue: 1 << 8)
    
    public static let owner = PermissionSet([
        .none,
        .appointments, 
        .statistic, 
        .employee, 
        .timetable, 
        .notifications,
        .salon, 
        .operations,
        .procedure
    ])

    // all
    public var rawValue: Int
    
    /// Инициализирует экземпляр с указанным сырым значением.
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
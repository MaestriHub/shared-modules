import Foundation

public struct AppointmentApprovedSet: OptionSet, Codable {
    
    public static let customer = AppointmentApprovedSet(rawValue: 1 << 0)
    public static let professional = AppointmentApprovedSet(rawValue: 1 << 1)
    
    public var rawValue: Int
    
    /// Инициализирует экземпляр с указанным сырым значением.
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

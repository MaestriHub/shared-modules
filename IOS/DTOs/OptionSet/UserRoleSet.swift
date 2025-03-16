import Foundation


public struct UserRoleSet: OptionSet, Codable, Hashable {
    
    public static let customer = UserRoleSet(rawValue: 1 << 0)
    public static let professional = UserRoleSet(rawValue: 1 << 1)
    
    public static let all: UserRoleSet = [.customer, .professional]
    
    public var rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

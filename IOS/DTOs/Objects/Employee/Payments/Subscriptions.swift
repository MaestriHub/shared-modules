import Foundation
import MemberwiseInit

@MemberwiseInit(.public)
public struct SubscriptionResponse: Codable {
    public var title         : String
    public var logoURL       : String
    public var description   : String
    
    public var yearlyPrice   : Int
    public var yearlyPayURL  : String
    
    public var monthlyPrice  : Int
    public var monthlyPayURL : String
}

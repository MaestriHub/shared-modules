import Foundation

public typealias SubscriptionListResponse = [SubscriptionResponse]

public struct SubscriptionResponse: Codable {
    var title         : String
    var logoURL       : String
    var description   : String
    
    var yearlyPrice   : Int
    var yearlyPayURL  : String
    
    var monthlyPrice  : Int
    var monthlyPayURL : String
}

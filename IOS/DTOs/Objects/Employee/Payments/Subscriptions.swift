import Foundation

typealias SubscriptionListDTO = [SubscriptionDTO]

struct SubscriptionDTO: Codable {
    var title         : String
    var logoURL       : String
    var description   : String
    
    var yearlyPrice   : Int
    var yearlyPayURL  : String
    
    var monthlyPrice  : Int
    var monthlyPayURL : String
}

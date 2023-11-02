import Foundation

/// Namespace для всех DTOs относящихся к Offtime
public enum Offtime {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

struct OfftimeBody: Codable {

    var reason: String?
    var interval: IntervalDate
    
}

//MARK: - Responses -

struct OfftimeResponse: Content {

    var id: UUID?
    var reason: String?
    var interval: IntervalDate
    
    init(offtime: OfftimeResponse) {
        id = offtime.id
        reason = offtime.reason
        interval = offtime.interval
    }
}

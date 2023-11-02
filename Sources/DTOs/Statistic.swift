import Foundation

//MARK: - Parameters -

struct AppointmentsStatisticQuery: Content, Validatable {

    let limit: IntervalDate
    
    static func validations(_ validations: inout Validations) {}
}


//MARK: - Responses -

struct AppointmentsStatisticResponse: Content {
    
    var limit: IntervalDate
    var price: Price
    var count: Int
}

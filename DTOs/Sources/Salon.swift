import Foundation

//MARK: - Parameters -

struct SalonFilterQuery: Codable {
    
}

struct SalonCreateBody: Codable {
    
    var name: String
    var type: String
    var logo: String?
    var timetable: TimetableBody
    var address: Address
    
}

struct SalonUpdateBody: Codable {
    
    var name: String?
    var logo: String?

//    static func validations(_ validations: inout Validations) {
//        validations.add("name", as: String.self, is: .alphanumeric)
//        validations.add("logo", as: String.self, is: .url)
//    }
    
//    func update(salon: Salon) {
//        if let name {
//            salon.name = name
//        }
//        salon.logo = logo
//    }
}

//MARK: - Responses for Pro -

struct SalonProResponse: Codable {
    var id: UUID?
    var name: String
    var species: String
    var logo: String?
    var address: Address
    var canEdit: Bool
    var timetable: TimetableResponse?
    var masters: [Employee]?
    
//    init(salon: Salon, canEdit: Bool, timetable: TimetableResponse?, masters: [Employee]? = nil) {
//        self.id = salon.id
//        self.name = salon.name
//        self.species = salon.type
//        self.logo = salon.logo
//        self.address = salon.address
//        self.canEdit = canEdit
//        self.timetable = timetable
//        self.masters = masters
//    }
}

//MARK: - Responses for Hub -

struct SalonCustomerResponse: Codable {
    var id: UUID?
    var name: String
    var species: String
    var logo: String?
    var address: Address
    var isFavorite: Bool
    var timetable: TimetableResponse?
    var masters: [Employee]?
    
    init(salon: Salon, isFavorite: Bool, timetable: TimetableResponse?, masters: [Employee]? = nil) {
        self.id = salon.id
        self.name = salon.name
        self.species = salon.type
        self.logo = salon.logo
        self.address = salon.address
        self.isFavorite = isFavorite
        self.timetable = timetable
        self.masters = masters
    }
}

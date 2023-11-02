import Foundation

/// Namespace для всех DTOs относящихся к Employee
public enum Employee {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Employee.Parameters {

}

//MARK: - Responses -

public extension Employee.Responses {
    
    struct Full: Codable {
        var id: UUID?
        var nickname: String
        var avatar: String?
        var timetable: TimetableResponse?
        var contacts: [Contact.Responses.Full]
        
        var procedures: [ProcedureResponse]?
    }
    
    struct EmployeeCustomerResponse: Codable {
        var id: UUID?
        var name: String
        var species: String
        var logo: String?
        var address: Address
        var isFavorite: Bool
        var timetable: TimetableResponse?
        var masters: [Employee]?
    }
}

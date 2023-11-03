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
    
    struct Full: Responsable {
        var id: UUID?
        var nickname: String
        var avatar: String?
        var contacts: [Contact.Responses.Full]
        
        var procedures: [Procedure.Responses.Full]?
    }
    
    struct Partial: Responsable {
        public var id: UUID?
        public var name: String
        public var contacts: [Contact.Responses.Full]
    }
}

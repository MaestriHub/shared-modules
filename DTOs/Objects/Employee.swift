import Foundation

/// Namespace для всех DTOs относящихся к Employee
public enum Employee {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Employee.Parameters {
    struct Create: Responsable {
        
    }
}

//MARK: - Responses -

public extension Employee.Responses {
    
    struct Full: Responsable {
        public var id: UUID?
        public var nickname: String
        public var avatar: String?
        public var contacts: [Contact.Responses.Full]
        
        public var procedures: [Procedure.Responses.Partial]?
    }
    
    struct Partial: Responsable {
        public var id: UUID?
        public var name: String
        public var contacts: [Contact.Responses.Full]
    }
}

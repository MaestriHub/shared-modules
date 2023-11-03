import Foundation

/// Namespace для всех DTOs относящихся к Procedure
public enum Procedure {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Procedure.Parameters {
    
    /// Query Parameters который передаются для фильтрации  Procedures
    struct Retrieve: Parametable {
        
    }
    
    /// Body Parameters который передаются для создания Procedure
    struct Create: Parametable {
        var name: String
        var type: String//Enum
        var logo: URL?
        var timetable: Timetable.Parameters.Create
        var address: Address.Parameters.Create
    }

    /// Body Parameters который передаются для частичного обновления Procedure
    struct Patch: Parametable {
        var name: String?
        var logo: String?
    }
}

//MARK: - Responses -

public extension Procedure.Responses {
    
    struct Full: Responsable {
        var id: UUID?

        
    }
    
    struct Partial: Responsable {
        var id: UUID?

    }
}

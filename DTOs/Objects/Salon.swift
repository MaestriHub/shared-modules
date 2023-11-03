import Foundation

/// Namespace для всех DTOs относящихся к Salon
public enum Salon {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Salon.Parameters {
    
    /// Query Parameters который передаются для фильтрации  Salon
    struct Retrieve: Parametable {
        
    }
    
    /// Body Parameters который передаются для создания Salon
    struct Create: Parametable {
        var name: String
        var type: String//Enum
        var logo: URL?
        var timetable: Timetable.Parameters.Create
        var address: Address.Parameters.Create
    }

    struct Patch: Parametable {
        var name: String?
        var logo: String?
    }
}

//MARK: - Responses -

public extension Salon.Responses {
    
    struct Full: Responsable {
        var id: UUID?
        var name: String
        var species: String
        var logo: String?
        var address: Address.Responses.Full
        var canEdit: Bool = false
        var isFavorite: Bool = false
        var timetable: Timetable.Responses.Full
        var masters: [Employee.Responses.Full]?
        
    }
    
    struct Partial: Responsable {
        var id: UUID?
        var name: String
        var species: String
        var logo: String?
        var address: Address.Responses.Full//String просто address
        var canEdit: Bool = false
        var isFavorite: Bool = false
    }
}

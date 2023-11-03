import Foundation

/// Namespace для всех DTOs относящихся к Notice
public enum Notice {
    public enum Responses {}
}

//MARK: - Responses -

public extension Notice.Responses {
    
    struct Full: Codable {
        var id: UUID?
        var title: String
        var body: String
        var date: Date?
    }
}

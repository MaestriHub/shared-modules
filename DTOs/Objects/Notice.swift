import Foundation

/// Namespace для всех DTOs относящихся к Notice
public enum Notice {
    public enum Responses {}
}

//MARK: - Responses -

public extension Notice.Responses {
    
    struct Full: Codable {
        public var id: UUID?
        public var title: String
        public var body: String
        public var date: Date?
    }
}

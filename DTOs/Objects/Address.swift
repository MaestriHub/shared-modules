import Foundation

/// Namespace для всех DTOs относящихся к Address
public enum Address {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Address.Parameters {
    
    struct Create: Responsable {
        public var address: String
        public var city: String
        public var country: String
        
        public var latitude: Double
        public var longitude: Double
    }
}

//MARK: - Responses -

public extension Address.Responses {
    
    struct Full: Responsable, Identifiable {
        public var id: UUID?
        
        public var address: String
        public var city: String
        public var country: String
        
        public var latitude: Double
        public var longitude: Double
    }
}

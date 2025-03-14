import Foundation
import MemberwiseInit

public enum Professional {
    public enum Parameters {}
    public enum Responses {}
}

public extension Professional.Parameters {
    
    @MemberwiseInit(.public)
    struct Create: Parametable {}
}

public extension Professional.Responses {
    
    @MemberwiseInit(.public)
    struct Partial: Responsable {
        public var user: User.Responses.Partial
    }
}

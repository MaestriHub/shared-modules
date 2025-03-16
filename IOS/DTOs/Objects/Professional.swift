import Foundation
import MemberwiseInit

public enum Professional {
    public enum Parameters {}
    public enum Responses {}
}

public extension Professional.Parameters {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Create: Parametable {}
}

public extension Professional.Responses {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Partial: Responsable {
        public var user: User.Responses.Partial
    }
}

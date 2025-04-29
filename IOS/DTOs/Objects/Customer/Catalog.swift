import Foundation
import MemberwiseInit

public enum Catalog {
    public enum Responses {}
}

public extension Catalog.Responses {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Catalog: Responsable {
        public let services: [Service.Helpers.ServiceResponse]
        public let procedures: [Procedure.Helpers.AllProcedureResponse]
        public let complexes: [Complex.Helpers.ComplexResponse]
    }
}

import Foundation

public enum Catalog {
    public enum Responses {}
}

public extension Catalog.Responses {
    
    struct Catalog: Codable, Sendable {
        public let procedures: [Procedure.Helpers.ProcedureResponse]
        public let complexes: [Complex.Helpers.ComplexResponse]
        
        public init(
            procedures: [Procedure.Helpers.ProcedureResponse],
            complexes: [Complex.Helpers.ComplexResponse]
        ) {
            self.procedures = procedures
            self.complexes = complexes
        }
    }
}

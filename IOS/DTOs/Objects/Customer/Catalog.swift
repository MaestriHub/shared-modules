import Foundation

public enum Catalog {
    public enum Responses {}
}

public extension Catalog.Responses {
    
    struct Catalog: Codable, Sendable {
        public let services: [Service.Helpers.ServiceResponse]
        public let procedures: [Procedure.Helpers.AllProcedureResponse]
        public let complexes: [Complex.Helpers.ComplexResponse]
        
        public init(
            services: [Service.Helpers.ServiceResponse],
            procedures: [Procedure.Helpers.AllProcedureResponse],
            complexes: [Complex.Helpers.ComplexResponse]
        ) {
            self.services = services
            self.procedures = procedures
            self.complexes = complexes
        }
    }
}

import Foundation
import MemberwiseInit

public enum Service {
    public enum Helpers {}
    
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Service.Parameters {
    
    @MemberwiseInit(.public)
    struct All: Parametable {
        public let salonsFilter: [UUID]?
        public let employeesFilter: [UUID]?
        public let valueFilter: String?
        public let pagination: Pagination?
    }

    @MemberwiseInit(.public)
    struct Create: Parametable {
        public let title: String
        public let tags: [ServiceTags]
    }

    @MemberwiseInit(.public)
    struct Update: Parametable {
        public let title: String?
        public let tags: [ServiceTags]?
    }
}

// MARK: - Responses -

public extension Service.Responses {
    
    @MemberwiseInit(.public)
    struct Create: Responsable {
        public let id: UUID
        public let title: String
        public let tags: [TranslatedServiceTag]
    }
    
    @MemberwiseInit(.public)
    struct Update: Responsable {
        public let id: UUID
        public let title: String
        public let tags: [TranslatedServiceTag]
    }
    
    @MemberwiseInit(.public)
    struct All: Responsable {
        public let services: [Service.Helpers.ServiceResponse]
    }
    
    @MemberwiseInit(.public)
    struct Retrieve: Responsable {
        public let id: UUID
        public let title: String
        public let parameters: [Service.Helpers.Parameter]
        public let tags: [TranslatedServiceTag]
    }
}

public extension Service.Helpers {
    
    @MemberwiseInit(.public)
    struct ServiceResponse: Codable {
        public let id: UUID
        public let title: String
        public let tags: [TranslatedServiceTag]    }
    
    @MemberwiseInit(.public)
    struct Parameter: Codable {
        public let id: UUID
        public let title: String
        public let cases: [Case]
    }

    @MemberwiseInit(.public)
    struct Case: Codable {
        public let id: Int
        public let title: String
    }
}

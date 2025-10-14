import Foundation
import MemberwiseInit

public enum Service {
    public enum Helpers {}
    
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Service.Parameters {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct All: Codable, Sendable {
        public let salonsFilter: [UUID]?
        public let employeesFilter: [UUID]?
        public let valueFilter: String?
        public let pagination: Pagination?
    }

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Create: Codable, Sendable {
        public let title: String
        public let tags: [ServiceTags]
    }

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Update: Codable, Sendable {
        public let title: String?
        public let tags: [ServiceTags]?
    }
}

// MARK: - Responses -

public extension Service.Responses {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Create: Codable, Sendable {
        public let id: UUID
        public let title: String
        public let tags: [TranslatedServiceTag]
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Update: Codable, Sendable {
        public let id: UUID
        public let title: String
        public let tags: [TranslatedServiceTag]
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct All: Codable, Sendable {
        public let services: [Service.Helpers.ServiceResponse]
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Retrieve: Codable, Sendable {
        public let id: UUID
        public let title: String
        public let parameters: [Service.Helpers.Parameter]
        public let tags: [TranslatedServiceTag]
    }
}

public extension Service.Helpers {
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct ServiceResponse: Codable, Sendable {
        public let id: UUID
        public let title: String
        public let tags: [TranslatedServiceTag]
    }
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Parameter: Codable, Sendable {
        public let id: UUID
        public let title: String
        public let cases: [Case]
    }

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Case: Codable, Sendable {
        public let id: Int
        public let title: String
    }
}

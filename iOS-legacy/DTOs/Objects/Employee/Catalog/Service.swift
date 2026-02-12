import Foundation

public enum Service {
    public enum Helpers {}
    
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Service.Parameters {
    
    struct All: Codable, Sendable {
        public let valueFilter: String?
        public let pagination: Pagination?
        
        public init(
            valueFilter: String? = nil,
            pagination: Pagination? = nil
        ) {
            self.valueFilter = valueFilter
            self.pagination = pagination
        }
    }

    struct Create: Codable, Sendable {
        public let title: String
        public let tags: [ServiceTags]
        
        public init(title: String, tags: [ServiceTags]) {
            self.title = title
            self.tags = tags
        }
    }

    struct Update: Codable, Sendable {
        public let title: String?
        public let tags: [ServiceTags]?
        
        public init(title: String? = nil, tags: [ServiceTags]? = nil) {
            self.title = title
            self.tags = tags
        }
    }
}

// MARK: - Responses -

public extension Service.Responses {

    typealias All = [Service.Helpers.ServiceResponse]
    
    struct Create: Codable, Sendable {
        public let id: UUID
        public let title: String
        public let tags: [TranslatedServiceTag]
        
        public init(id: UUID, title: String, tags: [TranslatedServiceTag]) {
            self.id = id
            self.title = title
            self.tags = tags
        }
    }
    
    struct Update: Codable, Sendable {
        public let id: UUID
        public let title: String
        public let tags: [TranslatedServiceTag]
        
        public init(id: UUID, title: String, tags: [TranslatedServiceTag]) {
            self.id = id
            self.title = title
            self.tags = tags
        }
    }
    
    struct Retrieve: Codable, Sendable {
        public let id: UUID
        public let title: String
        public let parameters: [Service.Helpers.Parameter]
        public let tags: [TranslatedServiceTag]
        
        public init(id: UUID, title: String, parameters: [Service.Helpers.Parameter], tags: [TranslatedServiceTag]) {
            self.id = id
            self.title = title
            self.parameters = parameters
            self.tags = tags
        }
    }
}

public extension Service.Helpers {
    
    struct ServiceResponse: Codable, Sendable {
        public let id: UUID
        public let title: String
        public let tags: [TranslatedServiceTag]
        
        public init(id: UUID, title: String, tags: [TranslatedServiceTag]) {
            self.id = id
            self.title = title
            self.tags = tags
        }
    }
    
    struct Parameter: Codable, Sendable {
        public let id: UUID
        public let title: String
        public let cases: [Case]
        
        public init(id: UUID, title: String, cases: [Case]) {
            self.id = id
            self.title = title
            self.cases = cases
        }
    }

    struct Case: Codable, Sendable {
        public let id: Int
        public let title: String
        
        public init(id: Int, title: String) {
            self.id = id
            self.title = title
        }
    }
}

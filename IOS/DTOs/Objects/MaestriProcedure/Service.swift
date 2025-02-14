import Foundation

public enum Service {
    public enum Helpers {}
    
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Service.Parameters {
    
    struct All: Parametable {
        public let salonsFilter: [UUID]?
        public let employeesFilter: [UUID]?
        public let valueFilter: String?
        public let pagination: Pagination?
        
        public init(
            salons: [UUID]? = nil,
            employees: [UUID]? = nil,
            value: String? = nil,
            pagination: Pagination? = nil
        ) {
            self.salonsFilter = salons
            self.employeesFilter = employees
            self.valueFilter = value
            self.pagination = pagination
        }
    }

    struct Create: Parametable {
        public let title: String
        public let tags: [ServiceTags]
        
        public init(
            title: String,
            tags: [ServiceTags]
        ) {
            self.title = title
            self.tags = tags
        }
    }

    struct Update: Parametable {
        public let title: String?
        public let tags: [ServiceTags]?
        
        public init(
            title: String? = nil,
            tags: [ServiceTags]? = nil
        ) {
            self.title = title
            self.tags = tags
        }
    }
}

// MARK: - Responses -

public extension Service.Responses {
    
    struct Create: Responsable {
        public let id: UUID
        public let title: String
        public let tags: [TranslatedServiceTag]
        
        public init(
            id: UUID,
            title: String,
            tags: [TranslatedServiceTag]
        ) {
            self.id = id
            self.title = title
            self.tags = tags
        }
    }
    
    struct Update: Responsable {
        public let id: UUID
        public let title: String
        public let tags: [TranslatedServiceTag]
        
        public init(
            id: UUID,
            title: String,
            tags: [TranslatedServiceTag]
        ) {
            self.id = id
            self.title = title
            self.tags = tags
        }
    }
    
    struct All: Responsable {
        public let services: [Service.Helpers.ServiceResponse]
        
        public init(
            services: [Service.Helpers.ServiceResponse]
        ) {
            self.services = services
        }
    }
    
    struct Retrieve: Responsable {
        public let id: UUID
        public let title: String
        public let parameters: [Service.Helpers.Parameter]
        public let tags: [TranslatedServiceTag]
        
        public init(
            id: UUID,
            title: String,
            parameters: [Service.Helpers.Parameter],
            tags: [TranslatedServiceTag]
        ) {
            self.id = id
            self.title = title
            self.tags = tags
            self.parameters = parameters
        }
    }
}

public extension Service.Helpers {
    struct ServiceResponse: Codable {
        public let id: UUID
        public let title: String
        public let tags: [TranslatedServiceTag]
        
        public init(
            id: UUID,
            title: String,
            tags: [TranslatedServiceTag]
        ) {
            self.id = id
            self.title = title
            self.tags = tags
        }
    }
    
    struct Parameter: Codable {
        public let id: UUID
        public let title: String
        public let cases: [Case]
        
        public init(
            id: UUID,
            title: String,
            cases: [Case]
        ) {
            self.id = id
            self.title = title
            self.cases = cases
        }
    }

    struct Case: Codable {
        public let id: Int
        public let title: String
        
        public init(
            id: Int,
            title: String
        ) {
            self.id = id
            self.title = title
        }
    }
}

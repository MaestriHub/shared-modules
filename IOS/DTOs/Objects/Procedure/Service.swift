import Foundation

public enum Service {
    public enum Parameters {}
    public enum Responses {}
}

public extension Service.Responses {
    enum Helpers {}
}

// MARK: - Parameters -

public extension Service.Parameters {
    
    struct All: Parametable {
        public let salonsFilter: [UUID]?
        public let employeesFilter: [UUID]?
        public let valueFilter: String?
        public let page: Int
        public let per: Int
        
        public init(
            salons: [UUID]? = nil,
            employees: [UUID]? = nil,
            value: String?,
            page: Int,
            per: Int
        ) {
            self.salonsFilter = salons
            self.employeesFilter = employees
            self.valueFilter = value
            self.page = page
            self.per = per
        }
    }

    struct Create: Parametable {
        public var title: String
        public var tags: [ServiceTags]
        
        public init(
            title: String,
            tags: [ServiceTags]
        ) {
            self.title = title
            self.tags = tags
        }
    }

    struct Update: Parametable {
        public var title: String?
        public var tags: [ServiceTags]?
        
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
        public var id: UUID
        public var title: String
        public var tags: [TranslatedServiceTag]
        
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
        public var id: UUID
        public var title: String
        public var tags: [TranslatedServiceTag]
        
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
        public var services: [Helpers.Service]
        
        public init(
            services: [Helpers.Service]
        ) {
            self.services = services
        }
    }
    
    struct Retrieve: Responsable {
        public var id: UUID
        public var title: String
        public var tags: [TranslatedServiceTag]
        
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
}

public extension Service.Responses.Helpers {
    struct Service: Codable {
        var id: UUID
        var title: String
        var tags: [TranslatedServiceTag]
        
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
}

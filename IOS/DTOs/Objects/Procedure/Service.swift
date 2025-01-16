import Foundation

public enum Service {
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Service.Parameters {
    
    struct All: Parametable {
        public let salonsFilter: [UUID]
        public let employeesFilter: [UUID]
        public let valueFilter: String?
        public let page: Int
        public let per: Int
        
        public init(
            salons: [UUID] = [],
            employees: [UUID] = [],
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
    
    struct Retrieve: Parametable {
        public let salon: UUID? // TODO: ?
        
        public init(
            salon: UUID? = nil
        ) {
            self.salon = salon
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
        
        public init(
            id: UUID
        ) {
            self.id = id
        }
    }
    
    struct Update: Responsable {
        public var id: UUID
        
        public init(
            id: UUID
        ) {
            self.id = id
        }
    }
    
    struct All: Responsable {
        public var id: UUID
        public var title: String
        public var tags: [ServiceTags]
        // TODO: parameters
        
        public init(
            id: UUID,
            title: String,
            tags: [ServiceTags]
        ) {
            self.id = id
            self.title = title
            self.tags = tags
        }
    }
    
    struct Retrieve: Responsable {
        public var id: UUID
        public var title: String
        public var tags: [ServiceTags]
        // TODO: parameters
        
        public init(
            id: UUID,
            title: String,
            tags: [ServiceTags]
        ) {
            self.id = id
            self.title = title
            self.tags = tags
        }
    }
}

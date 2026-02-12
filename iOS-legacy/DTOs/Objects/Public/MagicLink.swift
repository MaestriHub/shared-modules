import Foundation

public enum MagicLink {
    public enum Parameters {}
    public enum Responses {}
}

public extension MagicLink.Parameters {
    
    struct Click: Codable, Sendable {
        public let language: String
        public let languages: [String]
        public let cores: Int
        public let memory: Int
        public let screenWidth: Int
        public let screenHeight: Int
        public let colorDepth: Int
        public let pixelRatio: Double
        public let timeZone: String
        
        public init(
            language: String,
            languages: [String],
            cores: Int,
            memory: Int,
            screenWidth: Int,
            screenHeight: Int,
            colorDepth: Int,
            pixelRatio: Double,
            timeZone: String
        ) {
            self.language = language
            self.languages = languages
            self.cores = cores
            self.memory = memory
            self.screenWidth = screenWidth
            self.screenHeight = screenHeight
            self.colorDepth = colorDepth
            self.pixelRatio = pixelRatio
            self.timeZone = timeZone
        }
    }
}

public extension MagicLink.Responses {
    
    struct Full: Codable, Sendable {
        public let nanoId: String
        public let kind: MagicLinkKind
        public let isOneTime: Bool
        public let expiresAt: Date?
        public let usedAt: Date?
        public let createdAt: Date?
        
        public init(
            nanoId: String,
            kind: MagicLinkKind,
            isOneTime: Bool,
            expiresAt: Date? = nil,
            usedAt: Date? = nil,
            createdAt: Date? = nil
        ) {
            self.nanoId = nanoId
            self.kind = kind
            self.isOneTime = isOneTime
            self.expiresAt = expiresAt
            self.usedAt = usedAt
            self.createdAt = createdAt
        }
    }
}


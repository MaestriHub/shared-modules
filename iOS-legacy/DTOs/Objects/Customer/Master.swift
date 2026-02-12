import Foundation

public enum Master {
    public enum Responses {}
}

public extension Master.Responses {
    typealias Masters = [Master]
    
    struct Master: Codable, Sendable {
        public let id: UUID
        public let nickname: String
        public let logo: URL
        public let position: String
        
        public init(id: UUID, nickname: String, logo: URL, position: String) {
            self.id = id
            self.nickname = nickname
            self.logo = logo
            self.position = position
        }
    }
}


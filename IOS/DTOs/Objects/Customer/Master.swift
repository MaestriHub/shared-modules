import Foundation

public enum Master {
    public enum Responses {}
}

public extension Master.Responses {
    typealias Masters = [Master]
    
    struct Master: Codable, Sendable {
        public var id: UUID
        public var nickName: String
        public var logo: URL
        public var position: String
        
        public init(id: UUID, nickName: String, logo: URL, position: String) {
            self.id = id
            self.nickName = nickName
            self.logo = logo
            self.position = position
        }
    }
}


import Foundation
import MemberwiseInit

public enum Master {
    public enum Responses {}
}

public extension Master.Responses {
    typealias Masters = [Master]
    
    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Master: Codable {
        public var id: UUID
        public var nickName: String
        public var logo: URL
        public var position: String
    }
}


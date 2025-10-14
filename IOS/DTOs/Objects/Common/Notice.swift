import Foundation

public enum Notice {
    public enum Responses {}
}

public extension Notice.Responses {

    struct Full: Codable, Sendable {
        public var id: UUID
        public var titleKey: String
        public var messageKey: String
        public var parameters: [String: String]
        public var category: NoticeCategory
        public var isRead: Bool
        public var date: Date?
        
        public init(
            id: UUID,
            titleKey: String,
            messageKey: String,
            parameters: [String: String],
            category: NoticeCategory,
            isRead: Bool,
            date: Date? = nil
        ) {
            self.id = id
            self.titleKey = titleKey
            self.messageKey = messageKey
            self.parameters = parameters
            self.category = category
            self.isRead = isRead
            self.date = date
        }
    }
}

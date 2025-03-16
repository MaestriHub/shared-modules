import Foundation
import MemberwiseInit

public enum Notice {
    public enum Responses {}
}

public extension Notice.Responses {

    @MemberwiseInit(.public, _optionalsDefaultNil: true)
    struct Full: Responsable {
        public var id: UUID
        public var titleKey: String
        public var messageKey: String
        public var parameters: String?
        public var category: NoticeCategory
        public var isRead: Bool
        public var date: Date?
    }
}

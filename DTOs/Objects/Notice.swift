import Foundation

/// Пространство имен `Notice` содержит типы данных для работы с информацией о клиентах.
///
/// В него входят  модели ответов (`Responses`),
/// используемые для обмена данными между клиентом и сервером в контексте клиентских данных.
public enum Notice {
    public enum Responses {}
}

// MARK: - Responses -

public extension Notice.Responses {

    /// Полная информация об уведомлении.
    /// Включает в себя всю необходимую информацию об уведомлении, которое может быть представлено пользователю.
    ///
    /// ### Properties:
    /// - `id`: Уникальный идентификатор уведомления.
    /// - `title`: Заголовок уведомления, предоставляющий краткую суть сообщения.
    /// - `body`: Основное содержимое уведомления, которое переносит детальную информацию.
    /// - `date`: Дата и время создания уведомления, может быть `nil`, если дата не предоставляется.
    struct Full: Responsable, Identifiable, Equatable {
        public var id: UUID
        public var titleKey: String
        public var messageKey: String
        public var payload: [String: String]
        public var category: NoticeCategory
        public var isRead: Bool
        public var date: Date?

        public init(
            id: UUID,
            titleKey: String,
            messageKey: String,
            payload: [String: String],
            category: NoticeCategory,
            isRead: Bool,
            date: Date? = nil
        ) {
            self.id = id
            self.titleKey = titleKey
            self.messageKey = messageKey
            self.payload = payload
            self.category = category
            self.isRead = isRead
            self.date = date
        }
    }
}

import Foundation

/// Пространство имен `Notice` содержит типы данных для работы с информацией о клиентах.
///
/// В него входят  модели ответов (`Responses`),
/// используемые для обмена данными между клиентом и сервером в контексте клиентских данных.
public enum Notice {
    public enum Parameters {}
    public enum Responses {}
}

public extension Notice.Parameters {
    struct RegisterPush: Parametable {
        public enum RegisterPushToken: Codable {
            case apple(token: String)
            case fcm(token: String)
        }
        
        public let token: RegisterPushToken
        
        public init(token: RegisterPushToken) {
            self.token = token
        }
    }
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
        public var title: String
        public var body: String
        public var isRead: Bool
        public var date: Date?
        
        public init(
            id: UUID,
            title: String,
            body: String,
            isRead: Bool,
            date: Date? = nil
        ) {
            self.id = id
            self.title = title
            self.body = body
            self.isRead = isRead
            self.date = date
        }
    }
}

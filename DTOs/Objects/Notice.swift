import Foundation

/// Пространство имён для всех Data Transfer Objects (DTO), относящихся к уведомлениям.
public enum Notice {
    /// Пространство имён для структур ответов, связанных с уведомлениями.
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
    struct Full: Responsable, Identifiable {
        public var id: UUID
        public var title: String
        public var body: String
        public var date: Date?
    }
}

import Foundation

/// Пространство имен `Position` содержит типы данных для работы с информацией о сотрудниках.
///
/// Включает в себя параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// которые применяются для обмена данными о сотрудниках между клиентскими приложениями и сервером.
public enum Position {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Responses -

public extension Position.Responses {
    
    struct Full: Responsable, Identifiable, Equatable {
        public var id: UUID
        public var title: String
        public var permissions: PermissionSet
        public var salary: SalaryType

        public init(
            id: UUID,
            title: String,
            permissions: PermissionSet,
            salary: SalaryType
        ) {
            self.id = id
            self.title = title
            self.permissions = permissions
            self.salary = salary
        }
    }

}

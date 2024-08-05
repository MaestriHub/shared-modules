import Foundation

/// Пространство имен `Position` содержит типы данных для работы с информацией о сотрудниках.
///
/// Включает в себя параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// которые применяются для обмена данными о сотрудниках между клиентскими приложениями и сервером.
public enum Position {
    public enum Parameters {}
    public enum Responses {}
}


//MARK: - Parameters -

public extension Position.Parameters {
    
    struct Create: Parametable {
        public var title: String
        public var permissions: PermissionSet
        public var salary: Salary.Parameters.Create

        public init(
            title: String,
            permissions: PermissionSet,
            salary: Salary.Parameters.Create
        ){
            self.title = title
            self.permissions = permissions
            self.salary = salary
        }
    }

    struct Patch: Parametable {
        public var title: String?
        public var permissions: PermissionSet?
        public var salary: Salary.Parameters.Create?

        public init(
            title: String?,
            permissions: PermissionSet?,
            salary: Salary.Parameters.Create
        ){
            self.title = title
            self.permissions = permissions
            self.salary = salary
        }
    }
}

//MARK: - Responses -

public extension Position.Responses {
    
    struct Full: Responsable, Identifiable, Equatable {
        public var id: UUID
        public var title: String
        public var permissions: PermissionSet
        public var salary: Salary.Responses.Full

        public init(
            id: UUID,
            title: String,
            permissions: PermissionSet,
            salary: Salary.Responses.Full
        ) {
            self.id = id
            self.title = title
            self.permissions = permissions
            self.salary = salary
        }
    }

}

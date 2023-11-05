import Foundation

/// Пространство имен `Salon` содержит типы данных для взаимодействия с информацией о салонах красоты.
///
/// Включает параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обработки данных о салонах в системе.
public enum Salon {
    public enum Parameters {}
    public enum Responses {}
}

/// Перечисление `SalonType` определяет типы салонов, поддерживаемые в системе.
public enum SalonType: String, Codable {
    case individual  // Означает, что салон является индивидуальным предприятием.
    case chain       // Означает, что салон является частью сети.
    case master      // Означает, что салон управляется мастером.
}

//MARK: - Parameters -

public extension Salon.Parameters {
        
    /// Параметры для создания салона.
    /// Передаются в теле запроса при регистрации нового салона в системе.
    ///
    /// ### Properties:
    /// - name: Название салона.
    /// - type: Тип салона, определенный перечислением `SalonType`.
    /// - logo: URL адрес логотипа салона, может быть опущен.
    /// - timetable: Параметры для создания расписания салона (`Timetable.Parameters.Create`).
    /// - address: Параметры для создания адреса салона (`Address.Parameters.Create`).
    struct Create: Parametable {
        var name: String
        var type: SalonType
        var logo: URL?
        var timetable: Timetable.Parameters.Create
        var address: Address.Parameters.Create
    }

    /// Параметры для обновления информации о салоне.
    /// Передаются в теле запроса при изменении данных салона.
    ///
    /// ### Properties:
    /// - name: Новое название салона, если требуется обновление.
    /// - logo: Новый URL адрес логотипа, если требуется обновление.
    struct Patch: Parametable {
        var name: String?
        var logo: String?
    }
}

//MARK: - Responses -

public extension Salon.Responses {
    
    /// Полная информация о салоне для подробного отображения.
    ///
    /// ### Properties:
    /// - id: Уникальный идентификатор салона.
    /// - name: Название салона.
    /// - type: Тип салона, определенный перечислением `SalonType`.
    /// - logo: URL адрес логотипа салона, может быть `nil`.
    /// - address: Полная информация об адресе (`Address.Responses.Full`).
    /// - canEdit: Флаг, указывающий на возможность редактирования информации о салоне текущим пользователем.
    /// - isFavorite: Флаг, указывающий, отмечен ли салон как избранный у текущего пользователя.
    /// - timetable: Полная информация о расписании салона (`Timetable.Responses.Full`).
    /// - masters: Опциональный список мастеров салона с полной информацией (`Employee.Responses.Full`).
    struct Full: Responsable, Identifiable {
        public var id: UUID
        public var name: String
        public var type: SalonType
        public var logo: String?
        public var address: Address.Responses.Full
        public var canEdit: Bool = false
        public var isFavorite: Bool = false
        public var timetable: Timetable.Responses.Full
        public var masters: [Employee.Responses.Full]?
    }
    
    /// Упрощенная информация о салоне для краткого отображения.
    ///
    /// ### Properties:
    /// - id: Уникальный идентификатор салона.
    /// - name: Название салона.
    /// - type: Тип салона, определенный перечислением `SalonType`.
    /// - logo: URL адрес логотипа салона, может быть `nil`.
    /// - address: Краткая информация об адресе или просто строка адреса.
    /// - isFavorite: Флаг, указывающий, отмечен ли салон как избранный у текущего пользователя.
    struct Partial: Responsable, Identifiable {
        public var id: UUID
        public var name: String
        public var type: SalonType
        public var logo: String?
        public var address: Address.Responses.Full // В комментарии указано, что это строка, но тип указывает на полный объект адреса.
        public var isFavorite: Bool = false
    }
}


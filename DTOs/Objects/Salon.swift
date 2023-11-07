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
        public let name: String
        public let type: SalonType
        public let logo: URL?
        public let timetable: Timetable.Parameters.Create
        public let address: Address.Parameters.Create
        
        public init(
            name: String, 
            type: SalonType,
            logo: URL? = nil,
            timetable: Timetable.Parameters.Create,
            address: Address.Parameters.Create
        ) {
            self.name = name
            self.type = type
            self.logo = logo
            self.timetable = timetable
            self.address = address
        }
    }

    /// Параметры для обновления информации о салоне.
    /// Передаются в теле запроса при изменении данных салона.
    ///
    /// ### Properties:
    /// - name: Новое название салона, если требуется обновление.
    /// - logo: Новый URL адрес логотипа, если требуется обновление.
    struct Patch: Parametable {
        public let name: String?
        public let logo: String?
        
        public init(
            name: String? = nil,
            logo: String? = nil
        ) {
            self.name = name
            self.logo = logo
        }
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
        
        public init(
            id: UUID,
            name: String,
            type: SalonType,
            logo: String? = nil,
            address: Address.Responses.Full,
            canEdit: Bool,
            isFavorite: Bool,
            timetable: Timetable.Responses.Full,
            masters: [Employee.Responses.Full]? = nil
        ) {
            self.id = id
            self.name = name
            self.type = type
            self.logo = logo
            self.address = address
            self.canEdit = canEdit
            self.isFavorite = isFavorite
            self.timetable = timetable
            self.masters = masters
        }
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
        public var address: Address.Responses.Full // Может быть можно просто строку присылать
        public var isFavorite: Bool = false
        
        public init(
            id: UUID,
            name: String,
            type: SalonType,
            logo: String? = nil,
            address: Address.Responses.Full,
            isFavorite: Bool
        ) {
            self.id = id
            self.name = name
            self.type = type
            self.logo = logo
            self.address = address
            self.isFavorite = isFavorite
        }
    }
}


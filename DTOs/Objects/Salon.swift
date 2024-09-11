import Foundation

/// Пространство имен `Salon` содержит типы данных для взаимодействия с информацией о салонах красоты.
///
/// Включает параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обработки данных о салонах в системе.
public enum Salon {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Salon.Parameters {
        
    /// Параметры для создания салона.
    /// Передаются в теле запроса при регистрации нового салона в системе.
    struct Create: Parametable {
        public let name: String
        public let type: SalonType
        public let logo: URL?
        public let timeZoneId: String
        public let localeId: String
        public let description: String?
        public let timetable: Schedule.Week
        public let address: Address
        public var contacts: [Contact.Parameters.Create]
        
        public init(
            name: String, 
            type: SalonType,
            logo: URL? = nil,
            timeZoneId: String,
            localeId: String,
            description: String?,
            timetable: Schedule.Week,
            address: Address,
            contacts: [Contact.Parameters.Create]
        ) {
            self.name = name
            self.type = type
            self.logo = logo
            self.description = description
            self.timeZoneId = timeZoneId
            self.localeId = localeId
            self.timetable = timetable
            self.address = address
            self.contacts = contacts
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
        public let type: SalonType?
        public let description: String?
        public let logo: URL?
        public let timetable: Schedule.Week?
        
        public init(
            name: String? = nil,
            type: SalonType? = nil,
            description: String?,
            logo: URL? = nil,
            timetable: Schedule.Week? = nil
        ) {
            self.name = name
            self.type = type
            self.description = description
            self.logo = logo
            self.timetable = timetable
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
    struct Full: Responsable, Identifiable, Equatable {
        public var id: UUID
        public var name: String
        public var type: SalonType
        public var description: String?
        public var logo: URL?
        public var address: Address
        public var isActive: Bool
        public var canEdit: Bool = false
        public var isFavorite: Bool = false
        public var timetable: Timetable.Responses.Week
        public var localeId: String
        
        public init(
            id: UUID,
            name: String,
            type: SalonType,
            description: String?,
            logo: URL? = nil,
            address: Address,
            isActive: Bool,
            canEdit: Bool,
            isFavorite: Bool,
            timetable: Timetable.Responses.Week,
            localeId: String
        ) {
            self.id = id
            self.name = name
            self.type = type
            self.description = description
            self.logo = logo
            self.address = address
            self.isActive = isActive
            self.canEdit = canEdit
            self.isFavorite = isFavorite
            self.timetable = timetable
            self.localeId = localeId
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
    struct Partial: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
        public var name: String
        public var type: SalonType
        public var logo: URL?
        public var address: Address // Может быть можно просто строку присылать, но тогда не понятно как на карте отображать
        public var isFavorite: Bool = false
        
        public init(
            id: UUID,
            name: String,
            type: SalonType,
            logo: URL? = nil,
            address: Address,
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


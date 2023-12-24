import Foundation

/// Пространство имен `Address` содержит типы данных для работы с записями на прием.
///
/// В него входят как параметры для запросов (`Parameters`), так и модели ответов (`Responses`),
/// которые используются для сериализации данных, отправляемых и получаемых от API.
public enum Address {
    public enum Parameters {}
    public enum Responses {}
}

// MARK: - Parameters -

public extension Address.Parameters {
    
    /// Параметры для создания нового адреса.
    /// Структура содержит всю необходимую информацию для регистрации адреса в системе.
    ///
    /// ### Properties:
    ///   - address: Полное текстовое описание адреса.
    ///  - city: Название города, где находится адрес.
    ///  - country: Название страны, где находится адрес.
    ///  - latitude: Географическая широта адреса.
    ///  - longitude: Географическая долгота адреса.
    struct Create: Responsable {
        public let address: String
        public let city: String
        public let country: String
        public let latitude: Double
        public let longitude: Double
        
        public init(
            address: String,
            city: String,
            country: String,
            latitude: Double,
            longitude: Double
        ) {
            self.address = address
            self.city = city
            self.country = country
            self.latitude = latitude
            self.longitude = longitude
        }
    }
}

// MARK: - Responses -

public extension Address.Responses {
    
    /// Полные данные об адресе для ответа.
    /// Структура включает в себя идентификатор и основные данные об адресе, используемые для ответа в API.
    ///
    /// ### Properties:
    ///   - id: Уникальный идентификатор адреса.
    ///  - address: Полное текстовое описание адреса.
    ///  - city: Название города, где находится адрес.
    ///  - country: Название страны, где находится адрес.
    ///  - latitude: Географическая широта адреса.
    ///  - longitude: Географическая долгота адреса.
    struct Full: Responsable, Identifiable, Equatable {
        public var id: UUID
        public var address: String
        public var city: String
        public var country: String
        public var latitude: Double
        public var longitude: Double
        
        public init(
            id: UUID,
            address: String,
            city: String,
            country: String,
            latitude: Double,
            longitude: Double
        ) {
            self.id = id
            self.address = address
            self.city = city
            self.country = country
            self.latitude = latitude
            self.longitude = longitude
        }
    }
}

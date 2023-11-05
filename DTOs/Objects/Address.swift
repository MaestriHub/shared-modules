import Foundation

/// Пространство имён для всех DTO (Data Transfer Objects), относящихся к адресам.
/// Включает в себя структуры для параметров запросов и ответов, обеспечивающих стандартизированную передачу данных адресов.
public enum Address {
    /// Пространство имён для параметров запросов, связанных с адресами.
    public enum Parameters {}

    /// Пространство имён для структур ответов, связанных с адресами.
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
        public var address: String
        public var city: String
        public var country: String
        public var latitude: Double
        public var longitude: Double
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
    struct Full: Responsable, Identifiable {
        public var id: UUID
        public var address: String
        public var city: String
        public var country: String
        public var latitude: Double
        public var longitude: Double
    }
}

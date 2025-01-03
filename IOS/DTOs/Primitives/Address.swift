import Foundation

/// Полные данные об адресе для ответа.
/// Структура включает в себя идентификатор и основные данные об адресе, используемые для ответа в API.
///
/// ### Properties:
///  - address: Полное текстовое описание адреса.
///  - city: Название города, где находится адрес.
///  - country: Название страны, где находится адрес.
///  - latitude: Географическая широта адреса.
///  - longitude: Географическая долгота адреса.
public struct Address: Parametable, Responsable, Hashable, Equatable {
    public var address: String
    public var city: String
    public var country: String
    public var latitude: Double
    public var longitude: Double
    
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

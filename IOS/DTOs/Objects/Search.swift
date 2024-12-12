import Foundation

/// Пространство имен `Search` содержит типы данных для взаимодействия с информацией о салонах красоты.
///
/// Включает параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обработки данных о салонах в системе.
public enum Search {
    public enum Parameters {}
    public enum Responses {}
    
    public enum Helpers {}
}

//MARK: - Parameters -

public extension Search.Parameters {
    
    /// Параметры запроса для фильтрации списка салонов.
    /// Используются для передачи данных в поисковом запросе по критериям пользователя.
    ///
    /// ### Properties:
    /// - value: Поисковый запрос пользователя в виде строки.
    /// - salonType: Фильтр по типу салона
    /// - latitude: Широта центральной точки поиска.
    /// - longitude: Долгота центральной точки поиска.
    /// - latitudeDelta: Диапазон изменения широты от центральной точки.
    /// - longitudeDelta: Диапазон изменения долготы от центральной точки.
    ///
    /// Эти параметры позволяют проводить поиск салонов в заданном радиусе относительно указанной точки на карте.
    struct Retrieve: Parametable {
        public let value: String?
        public let salonType: SalonType?
        public let latitude: Double?
        public let longitude: Double?
        public let page: Int?
        public let per: Int?
        
        /// - Parameters:
        ///    - value: Поисковый запрос пользователя в виде строки.
        ///    - salonType: Фильтр по типу салона
        ///    - latitude: Широта центральной точки поиска.
        ///    - longitude: Долгота центральной точки поиска.
        ///    - page: Номер страницы для пагинации.
        ///    - per: Количество элементов на странице для пагинации.
        public init(
            value: String?,
            salonType: SalonType?,
            latitude: Double?,
            longitude: Double?,
            page: Int?,
            per: Int?
        ) {
            self.value = value
            self.salonType = salonType
            self.latitude = latitude
            self.longitude = longitude
            self.page = page
            self.per = per
        }
    }
}

//MARK: - Responses -

public extension Search.Responses {
    
    /// Ответ на поисковый запрос, содержащий предложения для автозаполнения.
    /// Позволяет пользователю выбрать из предложенных вариантов, основанных на начальных символах запроса.
    ///
    /// ### Properties:
    /// - value: Текст предложения, соответствующий части поискового запроса пользователя.
    struct Suggest: Responsable {
        public var value: String
        
        public init(value: String) {
            self.value = value
        }
    }
    
    /// Полный ответ на поисковый запрос, включающий предложения и результаты поиска.
    ///
    /// ### Properties:
    /// - suggests: Массив предложений для автозаполнения поискового запроса.
    /// - salons: Массив салонов, соответствующих поисковому запросу, в упрощенном представлении (`Salon.Responses.Partial`).
    struct Full: Responsable {
        public var suggests: [Suggest]
        public var salons: [Search.Helpers.Salon]
        
        public init(
            suggests: [Suggest],
            salons: [Search.Helpers.Salon]
        ) {
            self.suggests = suggests
            self.salons = salons
        }
    }
}

public extension Search.Helpers {
    
    struct Salon: Responsable, Identifiable, Hashable, Equatable {
        public var id: UUID
        public var name: String
        public var type: SalonType
        public var logo: URL?
        public var address: Address
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

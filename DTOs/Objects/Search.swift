import Foundation

/// Пространство имен `Search` включает в себя DTO (Data Transfer Objects),
/// которые используются для поисковых запросов и ответов на них.
public enum Search {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Search.Parameters {
    
    /// Параметры запроса для фильтрации списка салонов.
    /// Используются для передачи данных в поисковом запросе по критериям пользователя.
    ///
    /// ### Properties:
    /// - value: Поисковый запрос пользователя в виде строки.
    /// - latitude: Широта центральной точки поиска.
    /// - longitude: Долгота центральной точки поиска.
    /// - latitudeDelta: Диапазон изменения широты от центральной точки.
    /// - longitudeDelta: Диапазон изменения долготы от центральной точки.
    ///
    /// Эти параметры позволяют проводить поиск салонов в заданном радиусе относительно указанной точки на карте.
    struct Retrieve: Parametable {
        let value: String
        
        let latitude: Double
        let longitude: Double
        let latitudeDelta: Double
        let longitudeDelta: Double
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
    }
    
    /// Полный ответ на поисковый запрос, включающий предложения и результаты поиска.
    ///
    /// ### Properties:
    /// - suggests: Массив предложений для автозаполнения поискового запроса.
    /// - salons: Массив салонов, соответствующих поисковому запросу, в упрощенном представлении (`Salon.Responses.Partial`).
    struct Full: Responsable {
        public var suggests: [Suggest]
        public var salons: [Salon.Responses.Partial]
    }
}

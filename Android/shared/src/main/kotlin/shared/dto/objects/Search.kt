package com.maestri.sdk.sources.shared.dto.objects

import com.maestri.sdk.sources.shared.dto.enums.SalonType
import com.maestri.sdk.sources.shared.dto.protocols.Parametable
import com.maestri.sdk.sources.shared.dto.protocols.Responsable
import kotlinx.serialization.Serializable

/// Пространство имен `Search` содержит типы данных для взаимодействия с информацией о салонах красоты.
///
/// Включает параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обработки данных о салонах в системе.
object Search {
    //MARK: - Parameters -
    data object Parameters {
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
        /// - Parameters:
        ///    - value: Поисковый запрос пользователя в виде строки.
        ///    - salonType: Фильтр по типу салона
        ///    - latitude: Широта центральной точки поиска.
        ///    - longitude: Долгота центральной точки поиска.
        ///    - page: Номер страницы для пагинации.
        ///    - per: Количество элементов на странице для пагинации.
        @Serializable
        data class Retrieve(
            val value: String?,
            val salonType: SalonType?,
            val latitude: Double?,
            val longitude: Double?,
            val page: Int?,
            val per: Int?,
        ) : Parametable()
    }

    //MARK: - Responses -
    data object Responses {

        /// Ответ на поисковый запрос, содержащий предложения для автозаполнения.
        /// Позволяет пользователю выбрать из предложенных вариантов, основанных на начальных символах запроса.
        ///
        /// ### Properties:
        /// - value: Текст предложения, соответствующий части поискового запроса пользователя.
        @Serializable
        data class Suggest(
            val value: String,
        ) : Responsable

        /// Полный ответ на поисковый запрос, включающий предложения и результаты поиска.
        ///
        /// ### Properties:
        /// - suggests: Массив предложений для автозаполнения поискового запроса.
        /// - salons: Массив салонов, соответствующих поисковому запросу, в упрощенном представлении (`Salon.Responses.Partial`).
        data class Full(
            val suggests: List<Suggest>,
            val salons: List<Salon.Responses.Partial>,
        ) : Responsable
    }
}



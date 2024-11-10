package com.maestri.sdk.sources.shared.dto.objects

import shared.dto.enums.SalonType
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import kotlinx.serialization.Serializable
import shared.dto.objects.Salon

object Search {
    data object Parameters {
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

    data object Responses {
        @Serializable
        data class Suggest(
            val value: String,
        ) : Responsable

        data class Full(
            val suggests: List<Suggest>,
            val salons: List<Salon.Responses.Partial>,
        ) : Responsable
    }
}



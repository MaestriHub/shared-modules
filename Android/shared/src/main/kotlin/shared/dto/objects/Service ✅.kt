@file:UseSerializers(UUIDSerializer::class)

package com.maestri.sdk.sources.shared.dto.objects

import com.maestri.sdk.sources.shared.dto.enums.`ServiceCategory ✅`
import com.maestri.sdk.sources.shared.dto.primitives.`Price ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Parametable ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Responsable ✅`
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.UUID

/// Пространство имен `Service` содержит типы данных для взаимодействия с информацией о салонах красоты.
///
/// Включает параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обработки данных о салонах в системе.
object `Service ✅` {
    // MARK: - Parameters -
    data object Parameters {
        /// Параметры запроса для получения списка услуг.
        /// Могут включать фильтрацию и сортировку, но в данном примере не определены.
        @Serializable
        data class Retrieve(
            val salons: List<UUID>?,
            val employees: List<UUID>?,
            val value: String?,
            val page: Int,
            val per: Int,
        ) : `Parametable ✅`()

        @Serializable
        data class RetrieveFull(
            val salon: UUID?,
        ) : `Parametable ✅`()

        /// Параметры, передаваемые в теле запроса при создании новой услуги.
        /// Требуют указания обязательных полей для регистрации услуги в системе.
        ///
        /// ### Properties:
        /// - `title`: Название услуги.
        /// - `description`: Описание услуги, детализирующее предоставляемую процедуру.
        /// - 'language': Язык в стиле Access language
        @Serializable
        data class Create(
            val title: String,
            val description: String,
            val category: `ServiceCategory ✅`,
            val language: String?,
        ) : `Parametable ✅`()

        /// Параметры, передаваемые в теле запроса для частичного обновления данных об услуге.
        /// Позволяют изменить название и/или описание существующей услуги.
        ///
        /// ### Properties:
        /// - `title`: Новое название услуги (опционально).
        /// - `description`: Новое описание услуги (опционально).
        /// - 'language': Язык в стиле Access language (требуется для обновления title || description)
        @Serializable
        data class Patch(
            val title: String?,
            val description: String?,
            val category: `ServiceCategory ✅`?,
            val language: String,
        ) : `Parametable ✅`()
    }

    // MARK: - Responses -
    data object Responses {

        /// Полная структура ответа, содержащая все данные об услуге.
        /// Используется для передачи детальной информации о конкретной услуге.
        ///
        /// ### Properties:
        /// - `id`: Уникальный идентификатор услуги.
        /// - `title`: Название услуги.
        /// - `description`: Подробное описание услуги.
        @Serializable
        data class Full(
            val id: UUID,
            val title: String,
            val description: String,
            val category: `ServiceCategory ✅`,
            val procedures: List<`Procedure ✅`.Responses.Full>,
        ) : `Responsable ✅`

        /// Упрощенная структура ответа для услуг.
        /// Может использоваться для передачи краткой информации об услугах в списках или при кратком обзоре.
        ///
        /// ### Properties:
        /// - `id`: Уникальный идентификатор услуги.
        /// - `title`: Название услуги.
        /// - `description`: Описание услуги, содержащее основные характеристики.
        @Serializable
        data class Partial(
            val id: UUID,
            val title: String,
            val description: String,
            val category: `ServiceCategory ✅`,
            val minPrice: `Price ✅`?,
            val minDuration: Int?,
        ) : `Responsable ✅`

        @Serializable
        data class Micro(
            val id: UUID,
            val title: String,
            val description: String,
            val category: `ServiceCategory ✅`,
        ) : `Responsable ✅`
    }
}
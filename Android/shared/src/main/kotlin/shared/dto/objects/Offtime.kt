@file:UseSerializers(UUIDSerializer::class)

package com.maestri.sdk.sources.shared.dto.objects

import com.maestri.sdk.sources.shared.dto.protocols.`Parametable ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Responsable ✅`
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.UUID

/// Пространство имен `Offtime` содержит типы данных для взаимодействия с информацией о салонах красоты.
///
/// Включает параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обработки данных о салонах в системе.
object Offtime {
    // MARK: - Parameters -
    data object Parameters {
        /// Параметры для определения временных промежутков, когда услуги не будут доступны.
        /// Используется для учета периодов отгулов, отпусков и других нерабочих интервалов.
        @Serializable
        data class Create(
            val interval: DateInterval,
            val reason: String?,
            val timeZone: String,
        ) : `Parametable ✅`()
    }

    // MARK: - Responses -
    data object Responses {

        /// Структура полного ответа, содержащая расписание работы на неделю.
        /// Включает статус работы и расписание по дням недели в текстовом формате.
        @Serializable
        data class Full(
            val id: UUID,
            val interval: DateInterval,
            val reason: String?,
            val timeZone: String,
        ) : `Responsable ✅`

        @Serializable
        data class Partial(
            val id: UUID,
            val interval: DateInterval,
        ) : `Responsable ✅`
    }
}

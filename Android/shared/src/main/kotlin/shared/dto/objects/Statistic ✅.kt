@file:UseSerializers(UUIDSerializer::class, DateSerializer::class)

package com.maestri.sdk.sources.shared.dto.objects

import com.maestri.sdk.sources.shared.dto.primitives.`Price ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Parametable ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Responsable ✅`
import com.maestri.sdk.sources.shared.serializers.DateSerializer
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.Date
import java.util.UUID

/// Пространство имен `Statistic` содержит типы данных для взаимодействия с информацией о салонах красоты.
///
/// Включает параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обработки данных о салонах в системе.
object `Statistic ✅` {
    // MARK: - Parameters -
    data object Parameters {
        /// Параметры запроса для фильтрации статистики по записям на прием.
        /// Позволяют задать временной диапазон и фильтры для выборки статистических данных.
        ///
        /// ### Properties:
        /// - `startDate`: Начальная дата временного диапазона.
        /// - `endDate`: Конечная дата временного диапазона.
        /// - `employees`: Список идентификаторов сотрудников, для которых необходима статистика.
        /// - `salons`: Список идентификаторов салонов, для которых требуется статистика.
        @Serializable
        data class AppointmentsQuery(
            val startDate: Date,
            val endDate: Date,
            val employees: List<UUID>?,
            val salons: List<UUID>?,
        ) : `Parametable ✅`()
    }

    // MARK: - Responses -
    data object Responses {

        /// Структура, представляющая статистику по записям на прием.
        /// Включает в себя информацию о суммарной стоимости и количестве записей.
        ///
        /// ### Properties:
        /// - `price`: Общая сумма стоимости всех записей в заданном фильтре.
        /// - `count`: Общее количество записей на прием в заданном временном диапазоне и согласно указанным фильтрам.
        @Serializable
        data class Appointments(
            val price: `Price ✅`,
            val count: Int,
        ) : `Responsable ✅`
    }
}

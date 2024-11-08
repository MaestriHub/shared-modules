@file:UseSerializers(UUIDSerializer::class, DateSerializer::class)

package com.maestri.sdk.sources.shared.dto.objects

import com.maestri.sdk.sources.shared.dto.primitives.Price
import com.maestri.sdk.sources.shared.dto.protocols.Parametable
import com.maestri.sdk.sources.shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.DateSerializer
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.UUID

/// Пространство имен `Procedure` содержит типы данных для работы с информацией о сотрудниках.
///
/// Включает в себя параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// которые применяются для обмена данными о сотрудниках между клиентскими приложениями и сервером.
object Procedure {
    // MARK: - Parameters -
    data object Parameters {

        /// Параметры запроса для получения списка процедур.
        /// Позволяют фильтровать процедуры по определенным салонам и сотрудникам.
        ///
        /// ### Properties:
        /// - `salons`: Список идентификаторов салонов для фильтрации процедур.
        /// - `employees`: Список идентификаторов сотрудников для фильтрации процедур.
        @Serializable
        data class Retrieve(
            val salons: List<UUID>?,
            val employees: List<UUID>?,
        ) : Parametable()

        /// Параметры, передаваемые в теле запроса при создании новой процедуры.
        /// Требуют указания всех необходимых атрибутов процедуры.
        ///
        /// ### Properties:
        /// - `price`: Цена процедуры.
        /// - `duration`: Продолжительность процедуры в минутах.
        /// - `serviceId`: Идентификатор услуги, к которой относится процедура.
        /// - `employeeId`: Идентификатор работника, к которому привяжится процедура.
        @Serializable
        data class Create(
            val price: Price,
            val duration: Int,
            val description: String?,
            val alias: String?,
            val serviceId: UUID,
            val employeeId: UUID,
        ) : Parametable()

        /// Параметры, передаваемые в теле запроса для частичного обновления существующей процедуры.
        /// Позволяют изменить цену и/или продолжительность процедуры.
        ///
        /// ### Properties:
        /// - `price`: Новая цена процедуры (опционально).
        /// - `duration`: Новая продолжительность процедуры в минутах (опционально).
        @Serializable
        data class Patch(
            val priceval: Price?,
            val durationval: Int?,
            val description: String?,
            val alias: String?,
        ) : Parametable()
    }

    // MARK: - Responses -
    data object Responses {

        /// Полная структура ответа, содержащая все данные о процедуре.
        /// Используется для передачи полных деталей о процедуре, включая связанную услугу.
        ///
        /// ### Properties:
        /// - `id`: Уникальный идентификатор процедуры.
        /// - `price`: Цена процедуры.
        /// - `duration`: Продолжительность процедуры в минутах.
        /// - `service`: Полные данные о связанной услуге.
        @Serializable
        data class Full(
            val id: UUID,
            val price: Price,
            val duration: Int,
            val description: String?,
            val alias: String?,
            val service: Service.Responses.Partial,
            val master: Employee.Responses.Partial,
        ) : Responsable

        /// Упрощенная структура ответа для процедур.
        /// Может использоваться для передачи краткой информации о процедуре, включая основные данные связанной услуги.
        ///
        /// ### Properties:
        /// - `id`: Уникальный идентификатор процедуры.
        /// - `price`: Цена процедуры.
        /// - `duration`: Продолжительность процедуры в минутах.
        /// - `service`: Краткие данные о связанной услуге.
        @Serializable
        data class Partial(
            val id: UUID,
            val price: Price,
            val duration: Int,
            val description: String?,
            val alias: String?,
            val service: Service.Responses.Partial,
            val master: Employee.Responses.Partial,
        ) : Responsable
    }
}

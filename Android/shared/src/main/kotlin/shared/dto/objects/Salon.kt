@file:UseSerializers(UUIDSerializer::class, URISerializer::class)

package com.maestri.sdk.sources.shared.dto.objects

import shared.dto.objects.Timetable
import shared.dto.enums.`SalonType ✅`
import com.maestri.sdk.sources.shared.dto.primitives.`Address ✅`
import shared.dto.primitives.Schedule
import com.maestri.sdk.sources.shared.dto.protocols.`Parametable ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Responsable ✅`
import com.maestri.sdk.sources.shared.serializers.URISerializer
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.net.URI
import java.util.UUID

/// Пространство имен `Salon` содержит типы данных для взаимодействия с информацией о салонах красоты.
///
/// Включает параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обработки данных о салонах в системе.
object Salon {
    //MARK: - Parameters -
    data object Parameters {
        /// Параметры для создания салона.
        /// Передаются в теле запроса при регистрации нового салона в системе.
        @Serializable
        data class Create(
            val name: String,
            val type: `SalonType ✅`,
            val logo: URI?,
            val timeZone: String,
            val description: String?,
            val timetable: Schedule.Week,
            val address: `Address ✅`,
            var contacts: List<Contact.Parameters.Create>,
        ) : `Parametable ✅`()

        /// Параметры для обновления информации о салоне.
        /// Передаются в теле запроса при изменении данных салона.
        ///
        /// ### Properties:
        /// - name: Новое название салона, если требуется обновление.
        /// - logo: Новый URL адрес логотипа, если требуется обновление.
        @Serializable
        data class Patch(
            val name: String?,
            val type: `SalonType ✅`?,
            val description: String?,
            val logo: URI?,
            val timetable: Schedule.Week?,
        ) : `Parametable ✅`()
    }

    //MARK: - Responses -
    data object Responses {

        /// Полная информация о салоне для подробного отображения.
        ///
        /// ### Properties:
        /// - id: Уникальный идентификатор салона.
        /// - name: Название салона.
        /// - type: Тип салона, определенный перечислением `SalonType`.
        /// - logo: URL адрес логотипа салона, может быть `nil`.
        /// - address: Полная информация об адресе (`Address.Responses.Full`).
        /// - canEdit: Флаг, указывающий на возможность редактирования информации о салоне текущим пользователем.
        /// - isFavorite: Флаг, указывающий, отмечен ли салон как избранный у текущего пользователя.
        /// - timetable: Полная информация о расписании салона (`Timetable.Responses.Full`).
        /// - masters: Опциональный список мастеров салона с полной информацией (`Employee.Responses.Full`).
        @Serializable
        data class Full(
            var id: UUID,
            var name: String,
            var type: `SalonType ✅`,
            var description: String?,
            var logo: URI? = null,
            var address: `Address ✅`,
            var isActive: Boolean,
            var canEdit: Boolean = false,
            var isFavorite: Boolean = false,
            var timetable: Timetable.Responses.Week,
            var masters: List<Employee.Responses.Full>?,
        ) : `Responsable ✅`

        /// Упрощенная информация о салоне для краткого отображения.
        ///
        /// ### Properties:
        /// - id: Уникальный идентификатор салона.
        /// - name: Название салона.
        /// - type: Тип салона, определенный перечислением `SalonType`.
        /// - logo: URL адрес логотипа салона, может быть `nil`.
        /// - address: Краткая информация об адресе или просто строка адреса.
        /// - isFavorite: Флаг, указывающий, отмечен ли салон как избранный у текущего пользователя.
        @Serializable
        data class Partial(
            var id: UUID,
            var name: String,
            var type: `SalonType ✅`,
            var logo: URI? = null,
            var address: `Address ✅`, // Может быть можно просто строку присылать, но тогда не понятно как на карте отображать
            var isFavorite: Boolean = false,
        ) : `Responsable ✅`
    }
}


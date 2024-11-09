@file:UseSerializers(UUIDSerializer::class, URISerializer::class)

package com.maestri.sdk.sources.shared.dto.objects

import shared.dto.objects.`Timetable ✅`
import shared.dto.enums.ProfessionalEmployee
import com.maestri.sdk.sources.shared.dto.protocols.`Parametable ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Responsable ✅`
import com.maestri.sdk.sources.shared.serializers.URISerializer
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.UUID


/// Пространство имен `Employee` содержит типы данных для работы с информацией о сотрудниках.
///
/// Включает в себя параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// которые применяются для обмена данными о сотрудниках между клиентскими приложениями и сервером.
object `Employee ✅` {
    //MARK: - Parameters -
    data object Parameters {

        /// Параметры запроса для получения списка сотрудников.
        /// Позволяют фильтровать сотрудников по определенным салонам.
        ///
        /// ### Properties:
        /// - `salons`: Список идентификаторов салонов для фильтрации сотрудников.
        @Serializable
        data class Retrieve(
            val salonsId: List<UUID>,
        ) : `Parametable ✅`()

        /// Параметры, передаваемые в теле запроса при приглашение нового сотрудника.
        ///
        /// ### Properties:
        /// - `salondId`: Идентификатор салона
        @Serializable
        data class Invite(
            val salondId: UUID,
            val positionId: UUID,
            val contacts: List<`Contact ✅`.Parameters.Create>,
            val timetable: `Timetable ✅`.Parameters.Create.Pattern?,
            val description: String?,
        ) : `Parametable ✅`()

        /// Параметры для частичного обновления Employee.
        ///
        /// ### Properties:
        ///  - contacts: Контактная информация Employee, для связи с ним
        /// - timetable: Расписание времени работы
        @Serializable
        data class Patch(
            val positionId: UUID?,
        ) : `Parametable ✅`()
    }

    //MARK: - Responses -
    data object Responses {
        /// `Full` возвращает полный набор информации о сотруднике, предназначенный для подробного просмотра.
        ///
        /// ### Properties:
        /// - id: `UUID` - уникальный идентификатор сотрудника.
        /// - nickname: `String` - псевдоним сотрудника.
        /// - avatar: `URL?` - URL-адрес аватара сотрудника, может быть `nil`, если аватар отсутствует.
        /// - contacts: `[Contact.Responses.Full]` - полный список контактной информации сотрудника.
        /// - salonId: UUID - айдишник салона
        /// - procedures: `[Procedure.Responses.Partial]?` - опциональный список процедур, которые сотрудник выполняет.
        @Serializable
        data class Full(
            val id: UUID,
            val user: ProfessionalEmployee,
            val description: String?,
            val canEdit: Boolean = false,
            val contacts: List<`Contact ✅`.Responses.Full>,
            val salonId: UUID,
            val position: Position.Responses.Full,
        ) : `Responsable ✅`

        @Serializable
        data class Partial(
            val id: UUID,
            val user: `User ✅`.Responses.Partial?,
            val contacts: List<`Contact ✅`.Responses.Full>,
            val position: Position.Responses.Partial,
        ) : `Responsable ✅`
    }
}

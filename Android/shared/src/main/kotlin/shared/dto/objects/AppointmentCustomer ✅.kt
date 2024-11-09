@file:UseSerializers(UUIDSerializer::class, DateSerializer::class)

package shared.dto.objects

import com.maestri.sdk.sources.shared.dto.objects.*
import shared.dto.enums.`AppointmentStatus ✅`
import com.maestri.sdk.sources.shared.dto.primitives.`Address ✅`
import com.maestri.sdk.sources.shared.dto.primitives.`Price ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Parametable ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Responsable ✅`
import com.maestri.sdk.sources.shared.serializers.DateSerializer
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.AppointmentType
import java.util.Date
import java.util.UUID

object `AppointmentCustomer ✅` {
    //MARK: - Parameters -
    data object Parameters {

        /// Параметры запроса `Retrieve` определяют фильтры для получения записей на прием
        /// за определенный временной интервал с возможной фильтрацией по сотрудникам и салонам.
        ///
        /// ### Properties:
        ///   - startDate: `Date?` - начало временного интервала для выборки данных.
        ///  - endDate: `Date?` - конец временного интервала для выборки данных.
        ///  - employees: `[UUID]?` - необязательный массив идентификаторов сотрудников для фильтрации.
        ///  - salons: `[UUID]?` - необязательный массив идентификаторов салонов для фильтрации.
        /// Если массив не предоставлен, выборка осуществляется по всем сущностям.
        @Serializable
        data class Retrieve(
            val startDate: Date?,
            val endDate: Date?,
            val employees: List<UUID>?,
            val salons: List<UUID>?,
        ) : `Parametable ✅`()

        /// `Create` описывает параметры тела запроса для создания новой записи на прием.
        ///
        /// ### Properties:
        ///  - type: `AppointmentType` - Complex/Procedure
        ///  - time: `Interval` - временной интервал записи на прием.
        @Serializable
        data class Create(
            val type: AppointmentType,
            val time: `DateInterval ✅`,
        ) : `Parametable ✅`()

        /// `Patch` определяет параметры для частичного обновления данных записи на прием.
        ///
        /// ### Properties:
        ///   - time: ``Interval`` - новый временной интервал для записи, если требуется изменение.
        @Serializable
        data class Patch(
            val time: `DateInterval ✅`,
        ) : `Parametable ✅`()
    }

    //MARK: - Responses -
    data object Responses {
        /// `Full` представляет полную информацию о записи на прием, включая все связанные данные.
        ///
        /// ### Properties:
        ///   - id: `UUID` - уникальный идентификатор записи на прием.
        ///  - salon: ``Salon.Responses.Partial`` - информация о салоне.
        ///  - procedures: ``[Procedure.Responses.Partial]`` - список процедур.
        ///  - time: ``Interval`` - временной интервал записи.
        ///  - price: ``Price`` - цена записи.
        ///  - address: ``Address.Responses.Full`` - полная информация об адресе салона.
        @Serializable
        data class Full(
            val id: UUID,
            val status: `AppointmentStatus ✅`,
            val salon: Salon.Responses.Partial,
            val procedures: List<Procedure.Responses.Partial>,
            val time: `DateInterval ✅`,
            val price: `Price ✅`,
            val address: `Address ✅`,
        ) : `Responsable ✅`

        /// `Partial` содержит частичную информацию о записи на прием, обычно используемую для списков и обзоров.
        ///
        /// ### Properties:
        ///  - id: `UUID` - уникальный идентификатор записи.
        ///  - status ``AppointmentStatus`` -
        ///  - time: ``Interval`` - временной интервал записи.
        ///  - price: ``Price`` - цена записи.
        ///  - procedures: ``[Procedure.Responses.Partial]`` - исполняемые процедуры

        @Serializable
        data class Partial(
            val id: UUID,
            val status: `AppointmentStatus ✅`,
            val time: `DateInterval ✅`,
            val price: `Price ✅`,
            val procedures: List<Procedure.Responses.Partial>,
        ) : `Responsable ✅`
    }
}

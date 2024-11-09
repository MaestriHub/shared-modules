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

object `AppointmentEmployee ✅` {
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
        ///  - customer: UUID? - необязательный customer
        /// Если массив не предоставлен, выборка осуществляется по всем сущностям.
        @Serializable
        data class Retrieve(
            val startDate: Date?,
            val endDate: Date?,
            val employees: List<UUID>?,
            val salons: List<UUID>?,
            val customer: UUID?
        ) : `Parametable ✅`()

        /// `Create` описывает параметры тела запроса для создания новой записи на прием.
        ///
        /// ### Properties:
        ///  - customerId: UUID - id кастомера
        ///  - type: `AppointmentType` - Complex/Procedure
        ///  - time: `Interval` - временной интервал записи на прием.
        @Serializable
        data class Create(
            val customerId: UUID,
            val type: AppointmentType,
            val time: `DateInterval ✅`,
        ) : `Parametable ✅`()

        data class Approve(
            val appointmentsEmployeeId: List<UUID>,
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
        /// `Full` предоставляет информацию о конкретной AppointmentEmployee + об ассоциативных их
        ///
        /// ### Properties:
        ///  - salon: ``Salon.Responses.Partial`` - информация о салоне.
        ///  - customer: ``Customer.Responses.Partial`` - информация о customer.
        ///  - address: ``Address.Responses.Full`` - полная информация об адресе салона.
        ///  - associative: ``[Base]`` - ассоциативные
        @Serializable
        data class Full(
            val salon: `Salon ✅`.Responses.Partial,
            val customer: `Customer ✅`.Responses.Partial,
            val address: `Address ✅`,
            val associative: List<Base>,
        ) : `Responsable ✅`

        /// `Partial` содержит частичную информацию о записи на прием, обычно используемую для списков и обзоров.
        ///  - customer: ``Customer.Responses.Partial`` - информация о customer.
        ///  - associative: ``[Base]`` - ассоциативные
        @Serializable
        data class Partial(
            val customer: `Customer ✅`.Responses.Partial,
            val associative: List<Base>,
        ) : `Responsable ✅`

        /// `Base` Содержит основную информацию о AppointmentEmployee
        ///  - id: ``UUID`` - информация о customer.
        ///  - status: ``AppointmentStatus`` - информация о статусе
        ///  - procedure: ``Procedure.Responses.Partial`` - конкретная процедура
        ///  - time: ``DateInterval`` - время
        ///  - price: ``Price`` - стоимость
        @Serializable
        data class Base(
            val id: UUID,
            val status: `AppointmentStatus ✅`,
            val procedure: `Procedure ✅`.Responses.Partial,
            val time: `DateInterval ✅`,
            val price: `Price ✅`,
        ) : `Responsable ✅`
    }
}

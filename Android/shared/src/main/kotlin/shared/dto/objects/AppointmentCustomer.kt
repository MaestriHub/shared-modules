@file:UseSerializers(UUIDSerializer::class, DateSerializer::class)

package shared.dto.objects

import com.maestri.sdk.sources.shared.serializers.DateSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.AppointmentStatus
import shared.dto.enums.AppointmentType
import shared.dto.primitives.Address
import shared.dto.primitives.Price
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.UUIDSerializer
import java.util.*

object AppointmentCustomer {
    data object Parameters {
        @Serializable
        data class Retrieve(
            val startDate: Date?,
            val endDate: Date?,
            val employees: List<UUID>?,
            val salons: List<UUID>?,
        ) : Parametable()

        @Serializable
        data class Create(
            val type: AppointmentType,
            val time: DateInterval,
        ) : Parametable()

        @Serializable
        data class Patch(
            val time: DateInterval,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Full(
            val id: UUID,
            val status: AppointmentStatus,
            val salon: Salon.Responses.Partial,
            val procedures: List<Procedure.Responses.Partial>,
            val time: DateInterval,
            val price: Price,
            val address: Address,
        ) : Responsable

        @Serializable
        data class Partial(
            val id: UUID,
            val status: AppointmentStatus,
            val time: DateInterval,
            val price: Price,
            val procedures: List<Procedure.Responses.Partial>,
        ) : Responsable
    }
}
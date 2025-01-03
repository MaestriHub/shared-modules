@file:UseSerializers(
    UUIDSerializer::class,
    DateISOSerializer::class
)

package shared.dto.objects

import shared.serializers.DateISOSerializer
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

object AppointmentEmployee {
    data object Parameters {

        @Serializable
        data class Retrieve(
            val startDate: Date?,
            val endDate: Date?,
            val employees: List<UUID>?,
            val salons: List<UUID>?,
            val customer: UUID?
        ) : Parametable()

        @Serializable
        data class Create(
            val customerId: UUID,
            val type: AppointmentType,
            val time: DateInterval,
        ) : Parametable()

        @Serializable
        data class Approve(
            val appointmentsEmployeeId: List<UUID>,
        ) : Parametable()

        @Serializable
        data class Patch(
            val time: DateInterval,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Full(
            val salon: Salon.Responses.Partial,
            val customer: Customer.Responses.Partial,
            val address: Address,
            val associative: List<Base>,
        ) : Responsable

        @Serializable
        data class Partial(
            val customer: Customer.Responses.Partial,
            val associative: List<Base>,
        ) : Responsable

        @Serializable
        data class Base(
            val id: UUID,
            val status: AppointmentStatus,
            val procedure: Procedure.Responses.Partial,
            val time: DateInterval,
            val price: Price,
        ) : Responsable
    }
}

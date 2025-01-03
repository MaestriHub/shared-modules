@file:UseSerializers(
    UUIDSerializer::class,
    DateISOSerializer::class
)

package shared.dto.objects

import shared.serializers.DateISOSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.primitives.Price
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.UUIDSerializer
import java.util.*

object Statistic {
    data object Parameters {
        @Serializable
        data class AppointmentsQuery(
            val startDate: Date,
            val endDate: Date,
            val employees: List<UUID>?,
            val salons: List<UUID>?,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Appointments(
            val price: Price,
            val count: Int,
        ) : Responsable
    }
}
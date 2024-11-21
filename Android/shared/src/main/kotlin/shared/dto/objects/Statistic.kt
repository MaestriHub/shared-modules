@file:UseSerializers(UUIDSerializer::class)

package shared.dto.objects

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
                @Contextual
                val startDate: Date,
                @Contextual
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
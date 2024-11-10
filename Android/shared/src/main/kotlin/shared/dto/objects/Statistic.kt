@file:UseSerializers(UUIDSerializer::class, DateSerializer::class)

package shared.dto.objects

import shared.dto.primitives.Price
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.DateSerializer
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.Date
import java.util.UUID

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

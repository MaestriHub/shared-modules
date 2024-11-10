@file:UseSerializers(UUIDSerializer::class)

package shared.dto.objects

import shared.dto.enums.TimetableOwner
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.UUID

object Offtime {
    // MARK: - Parameters -
    data object Parameters {
        @Serializable
        data class Create(
            val interval: DateInterval,
            val reason: String?,
            val coefficient: Float, // BigDecimal?
        ) : Parametable()

        @Serializable
        data class Retrieve(
            val owners: List<TimetableOwner>,
            val period: DateInterval,
        )
    }

    data object Responses {
        @Serializable
        data class Full(
            val id: UUID,
            val interval: DateInterval,
            val reason: String?,
            val timeZoneId: String,
            val coefficient: Float,
        ) : Responsable

        @Serializable
        data class Partial(
            val id: UUID,
            val interval: DateInterval,
        ) : Responsable
    }
}

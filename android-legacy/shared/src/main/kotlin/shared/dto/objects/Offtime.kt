@file:UseSerializers(UUIDSerializer::class, TimetableOwnerSerializer::class, BigDecimalSerializer::class)

package shared.dto.objects

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.TimetableOwner
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.BigDecimalSerializer
import shared.serializers.TimetableOwnerSerializer
import shared.serializers.UUIDSerializer
import java.math.BigDecimal
import java.util.*

object Offtime {
    data object Parameters {
        @Serializable
        data class Create(
            val interval: DateInterval,
            val reason: String?,
            val coefficient: BigDecimal
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
            val reason: String? = null,
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

@file:UseSerializers(UUIDSerializer::class)

package shared.dto.objects.finance

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.PaymentType
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.UUIDSerializer
import java.util.*

object Cashbox {
    data object Parameters {
        @Serializable
        data class Create(
            val salonId: UUID,
            val paymentType: PaymentType,
        ) : Parametable()

        @Serializable
        data class Retrieve(
            val paymentType: PaymentType?,
            @Contextual
            val startDate: Date?,
            @Contextual
            val endDate: Date?,
        ) : Parametable()
    }

    data object Responses {
        data class Full(
            val id: UUID,
            @Contextual
            val createDate: Date,
            val paymentType: PaymentType,
        ) : Responsable
    }
}

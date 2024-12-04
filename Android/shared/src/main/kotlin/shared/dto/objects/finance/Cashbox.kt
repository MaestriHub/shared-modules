@file:UseSerializers(
    UUIDSerializer::class,
    DateISOSerializer::class
)


package shared.dto.objects.finance

import shared.serializers.DateISOSerializer
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
            val startDate: Date?,
            val endDate: Date?,
        ) : Parametable()
    }

    data object Responses {
        data class Full(
            val id: UUID,
            val createDate: Date,
            val paymentType: PaymentType,
        ) : Responsable
    }
}

@file:UseSerializers(UUIDSerializer::class)

package shared.dto.objects

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.PaymentType
import shared.dto.enums.SalaryPaymentType
import shared.dto.primitives.Price
import shared.dto.primitives.Wage
import shared.dto.protocols.Parametable
import shared.serializers.UUIDSerializer
import java.util.*

object Salary {
    data object Parameters {
        data object Rules {
            @Serializable
            data class Create(
                    val percent: Int?,
                    val grid: Map<UUID, SalaryPaymentType>?,
                    val wage: Wage,
            ) : Parametable()
        }

        data object Balance {
            @Serializable
            data class Payout(
                    val paymentType: PaymentType,
                    @Contextual
                    val dateTo: Date,
            ) : Parametable()

            @Serializable
            data class Calculate(
                    @Contextual
                    val dateTo: Date,
            ) : Parametable()
        }
    }

    data object Responses {
        data object Rules {
            @Serializable
            data class Full(
                    val percent: Int?,
                    val grid: Map<UUID, SalaryPaymentType>?,
                    val wage: Wage?,
            ) : Parametable()
        }

        data object Balance {
            @Serializable
            data class Full(
                    val wage: Price?,
                    val grid: List<Price>?,
                    val procent: List<Price>?,
                    val sum: List<Price>?,
            ) : Parametable()
        }
    }
}


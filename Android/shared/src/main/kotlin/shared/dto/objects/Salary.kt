@file:UseSerializers(
    UUIDSerializer::class,
    DateISOSerializer::class
)
package shared.dto.objects

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.PaymentType
import shared.dto.enums.SalaryPaymentType
import shared.dto.primitives.Price
import shared.dto.primitives.Wage
import shared.dto.protocols.Parametable
import shared.serializers.UUIDSerializer
import shared.serializers.DateISOSerializer
import java.util.Date
import java.util.UUID

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
                val dateTo: Date,
            ) : Parametable()

            @Serializable
            data class Calculate(
                val dateTo: Date,
            ) : Parametable()
        }
    }

    data object Responses {

        data object Helpers {

            @Serializable
            data class ServiceWithPaymentType(
                val service: Service.Responses.Partial,
                val paymentType: SalaryPaymentType
            )
        }

        data object Rules {
            @Serializable
            data class Full(
                val percent: Int? = null,
                val grid: List<Helpers.ServiceWithPaymentType>? = null,
                val wage: Wage? = null,
            ) : Parametable()
        }

        data object Balance {
            @Serializable
            data class Full(
                val wage: Price? = null,
                val grid: List<Price>? = null,
                val percent: List<Price>? = null,
                val sum: List<Price>? = null,
            ) : Parametable()
        }
    }
}

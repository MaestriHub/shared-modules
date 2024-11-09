@file:UseSerializers(UUIDSerializer::class, DateSerializer::class)

package shared.dto.objects

import com.maestri.sdk.sources.shared.dto.primitives.`Price ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Parametable ✅`
import com.maestri.sdk.sources.shared.serializers.DateSerializer
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.`PaymentType ✅`
import shared.dto.enums.`SalaryPaymentType ✅`
import shared.dto.enums.SalaryType
import java.util.Date
import java.util.UUID

object `Salary ✅` {
    //MARK: - Parameters -
    data object Parameters {

        data object Rules {
            @Serializable
            data class Create(
                val percent: Int?,
                val grid: Map<UUID, `SalaryPaymentType ✅`>?,
                val wage: SalaryType.Wage?,
            ) : `Parametable ✅`()
        }

        data object Balance {
            @Serializable
            data class Payout(
                val paymentType: `PaymentType ✅`,
                val dateTo: Date,
            ) : `Parametable ✅`()

            @Serializable
            data class Calculate(
                val dateTo: Date,
            ) : `Parametable ✅`()
        }
    }

    //MARK: - Responses -
    data object Responses {

        data object Rules {
            @Serializable
            data class Full(
                val percent: Int?,
                val grid: Map<UUID, `SalaryPaymentType ✅`>?,
                val wage: SalaryType.Wage?,
            ) : `Parametable ✅`()
        }

        data object Balance {
            @Serializable
            data class Full(
                val wage: `Price ✅`?,
                val grid: List<`Price ✅`>?,
                val procent: List<`Price ✅`>?,
                val sum: List<`Price ✅`>?,
            ) : `Parametable ✅`()
        }
    }
}


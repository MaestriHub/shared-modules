@file:UseSerializers(BigDecimalSerializer::class)

package shared.dto.primitives

import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.serializers.BigDecimalSerializer
import java.math.BigDecimal

@Serializable
data class Price(
    val amount: BigDecimal,
    val currency: String,
) : Parametable(), Responsable

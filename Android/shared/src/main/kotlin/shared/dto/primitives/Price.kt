package shared.dto.primitives

import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import kotlinx.serialization.Serializable

@Serializable
data class Price(
    val amount: Float, // BigDecimal ?
    val currency: String,
) : Parametable(), Responsable

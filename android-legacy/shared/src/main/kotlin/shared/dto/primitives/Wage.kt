package shared.dto.primitives

import kotlinx.serialization.Serializable
import shared.dto.enums.PaymentPeriod
import shared.dto.protocols.Responsable

@Serializable
data class Wage(
    val price: Price,
    val period: PaymentPeriod
) : Responsable
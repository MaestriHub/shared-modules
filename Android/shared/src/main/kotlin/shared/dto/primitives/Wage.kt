package shared.dto.primitives

import shared.dto.protocols.Responsable
import kotlinx.serialization.Serializable
import shared.dto.enums.PaymentPeriod

@Serializable
data class Wage(
    val price: Price,
    val period: PaymentPeriod
) : Responsable
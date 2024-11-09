package shared.dto.primitives

import com.maestri.sdk.sources.shared.dto.primitives.`Price ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Responsable ✅`
import kotlinx.serialization.Serializable
import shared.dto.enums.`PaymentPeriod ✅`

@Serializable
data class `Wage ✅`(
    val price: `Price ✅`,
    val period: `PaymentPeriod ✅`
) : `Responsable ✅`
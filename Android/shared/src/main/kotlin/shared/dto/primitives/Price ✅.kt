package com.maestri.sdk.sources.shared.dto.primitives

import com.maestri.sdk.sources.shared.dto.protocols.`Parametable ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Responsable ✅`
import kotlinx.serialization.Serializable

@Serializable
data class `Price ✅`(
    val amount: Float, // BigDecimal из java?
    val currency: String,
) : `Parametable ✅`(), `Responsable ✅`

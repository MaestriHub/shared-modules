package shared.dto.primitives

import kotlinx.serialization.Serializable
import shared.dto.protocols.Parametable

@Serializable
data class Pagination(
    val amount: Int,
    val currency: Int,
) : Parametable()
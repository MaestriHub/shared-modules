package shared.dto.primitives

import kotlinx.serialization.Serializable
import shared.dto.protocols.Parametable

@Serializable
data class Pagination(
    val page: Int,
    val per: Int,
) : Parametable()
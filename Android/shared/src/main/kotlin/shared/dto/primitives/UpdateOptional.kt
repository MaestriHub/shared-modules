package shared.dto.primitives

import kotlinx.serialization.Serializable
import shared.dto.protocols.Parametable

@Serializable
data class UpdateString(
    val value: String?
): Parametable()
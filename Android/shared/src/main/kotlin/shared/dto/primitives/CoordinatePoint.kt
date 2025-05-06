package shared.dto.primitives

import kotlinx.serialization.Serializable
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable

@Serializable
data class CoordinatePoint(
    val latitude: Double,
    val longitude: Double,
) : Parametable(), Responsable

package shared.dto.primitives

import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import kotlinx.serialization.Serializable

@Serializable
data class Address(
    val address: String,
    val city: String,
    val country: String,
    val latitude: Double,
    val longitude: Double,
) : Parametable(), Responsable

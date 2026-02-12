@file:UseSerializers(DateISOSerializer::class)

package shared.dto.primitives

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.protocols.Parametable
import shared.serializers.DateISOSerializer
import shared.dto.protocols.Responsable
import java.util.Date

@Serializable
data class Token(
    val value: String,
    val expiration: Date,
) : Parametable(), Responsable

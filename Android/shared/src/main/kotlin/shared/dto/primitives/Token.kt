@file:UseSerializers(DateSerializer::class)

package shared.dto.primitives

import com.maestri.sdk.sources.shared.serializers.DateSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.protocols.Responsable
import java.util.*

@Serializable
data class Token(
    val value: String,
    val expiration: Date,
) : Responsable
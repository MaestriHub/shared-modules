@file:UseSerializers(DateSerializer::class)

package shared.dto.primitives

import shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.DateSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.Date

@Serializable
data class Token(
    val value: String,
    val expiration: Date,
) : Responsable
@file:UseSerializers(DateSerializer::class)

package shared.dto.objects

import com.maestri.sdk.sources.shared.serializers.DateSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.*

@Serializable
data class DateInterval(
    val duration: Int,
    val start: Date,
)
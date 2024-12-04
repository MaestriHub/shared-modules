package shared.dto.objects

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.*

@Serializable
data class DateInterval(
    val duration: Int,
    @Contextual
    val start: Date,
)
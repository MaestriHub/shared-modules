package shared.dto.objects

import kotlinx.serialization.Serializable
import shared.serializers.DateISOSerializer
import java.util.*

@Serializable
data class DateInterval(
    @Serializable(with = DateISOSerializer::class)
    val start: Date,
    @Serializable(with = DateISOSerializer::class)
    val end: Date,
)
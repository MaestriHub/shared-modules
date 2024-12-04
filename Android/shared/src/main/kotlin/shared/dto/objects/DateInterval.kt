package shared.dto.objects

import shared.serializers.DateUNIXSerializer
import kotlinx.serialization.Serializable
import java.util.*

@Serializable
data class DateInterval(
    val duration: Int,
    @Serializable(with = DateUNIXSerializer::class)
    val start: Date,
)
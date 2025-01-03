package shared.dto.objects

import kotlinx.serialization.Serializable
import shared.serializers.DateUNIXSerializer
import java.util.*

@Serializable
data class DateInterval(
    val duration: Int,
    @Serializable(with = DateUNIXSerializer::class)
    val start: Date,
)
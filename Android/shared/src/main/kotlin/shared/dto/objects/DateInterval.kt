package shared.dto.objects

import kotlinx.serialization.Serializable
import shared.serializers.DateISOSerializer
import shared.serializers.DateUNIXSerializer
import java.util.*

@Serializable
data class DateISOInterval(
    val duration: Int,
    @Serializable(with = DateISOSerializer::class)
    val start: Date,
)

@Serializable
data class DateUNIXInterval(
    val duration: Int,
    @Serializable(with = DateUNIXSerializer::class)
    val start: Date,
)
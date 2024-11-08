@file:UseSerializers(DateSerializer::class)

package com.maestri.sdk.sources.shared.dto.objects


import com.maestri.sdk.sources.shared.serializers.DateSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.Date

@Serializable
data class DateInterval(
    val duration: Int,
    val start: Date,
)
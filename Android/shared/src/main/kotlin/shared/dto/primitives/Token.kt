@file:UseSerializers(DateSerializer::class)

package com.maestri.sdk.sources.shared.dto.primitives

import com.maestri.sdk.sources.shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.DateSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.Date


@Serializable
data class Token(
    val value: String,
    val expiration: Date,
) : Responsable
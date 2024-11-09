@file:UseSerializers(UUIDSerializer::class)

package com.maestri.sdk.sources.shared.dto.enums

import com.maestri.sdk.sources.shared.dto.protocols.`Parametable ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Responsable ✅`
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.UUID

// Тут явно нужено свой десериализатор
@Serializable
sealed class TimetableOwner : `Parametable ✅`(), `Responsable ✅` {
    val description: String
        get() = when (this) {
            is Employee -> "employee:$id"
            is Salon -> "salon:$id"
        }

    @Serializable
    @SerialName("salon")
    data class Salon(
        val id: UUID,
    ) : TimetableOwner()

    @Serializable
    @SerialName("employee")
    data class Employee(
        val id: UUID,
    ) : TimetableOwner()
}

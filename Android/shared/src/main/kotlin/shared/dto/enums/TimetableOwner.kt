@file:UseSerializers(UUIDSerializer::class, TimetableOwnerSerializer::class)

package shared.dto.enums

import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.serializers.TimetableOwnerSerializer
import java.util.UUID

sealed class TimetableOwner : Parametable(), Responsable {
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
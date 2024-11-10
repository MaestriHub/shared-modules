@file:UseSerializers(UUIDSerializer::class)

package shared.dto.enums

import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.UUID

@Serializable
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

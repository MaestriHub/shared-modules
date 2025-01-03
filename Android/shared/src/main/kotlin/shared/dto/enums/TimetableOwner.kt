@file:UseSerializers(UUIDSerializer::class, TimetableOwnerSerializer::class)

package shared.dto.enums

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.TimetableOwnerSerializer
import shared.serializers.UUIDSerializer
import java.util.*

sealed class TimetableOwner : Parametable(), Responsable {
    val description: String
        get() = when (this) {
            is Employee -> "employee:$employee"
            is Salon -> "salon:$salon"
        }

    @Serializable
    @SerialName("salon")
    data class Salon(
        val salon: UUID,
    ) : TimetableOwner()

    @Serializable
    @SerialName("employee")
    data class Employee(
        val employee: UUID,
    ) : TimetableOwner()
}
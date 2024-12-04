@file:UseSerializers(UUIDSerializer::class, URISerializer::class)

package shared.dto.objects

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.ProfessionalEmployee
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.URISerializer
import shared.serializers.UUIDSerializer
import java.util.*

object Employee {
    data object Parameters {
        @Serializable
        data class Retrieve(
            val salonsId: List<UUID>,
        ) : Parametable()

        @Serializable
        data class Invite(
            val salonId: UUID,
            val positionId: UUID,
            val contacts: List<Contact.Parameters.Create>,
            val timetable: Timetable.Parameters.Create.Pattern?,
            val description: String?,
        ) : Parametable()

        @Serializable
        data class Patch(
            val positionId: UUID?,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Full(
            val id: UUID,
            val user: ProfessionalEmployee,
            val description: String? = null,
            val canEdit: Boolean = false,
            val contacts: List<Contact.Responses.Full>,
            val salonId: UUID,
            val position: Position.Responses.Full,
        ) : Responsable

        @Serializable
        data class Partial(
            val id: UUID,
            val user: User.Responses.Partial?,
            val contacts: List<Contact.Responses.Full>,
            val position: Position.Responses.Partial,
        ) : Responsable
    }
}

@file:UseSerializers(UUIDSerializer::class, URISerializer::class)

package shared.dto.objects

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.ContactType
import shared.dto.enums.ProfessionalEmployee
import shared.dto.objects.contacts.Contact
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.URISerializer
import shared.serializers.UUIDSerializer
import java.net.URI
import java.util.*

object Employee {
    data object Parameters {
        @Serializable
        data class Retrieve(
            val salonsId: List<UUID>,
        ) : Parametable()

        @Serializable
        data class Invite(
            val nickname: String?,
            val salonId: UUID,
            val positionId: UUID,
            val contact: Internal.Contact? = null,
            val timetable: Timetable.Parameters.Create.Pattern? = null,
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
            val canEdit: Boolean = false,
            val contacts: List<Contact.Shared.PrimaryContact>,
            val salonId: UUID,
            val position: Position.Responses.Full,
        ) : Responsable

        @Serializable
        data class Partial(
            val id: UUID,
            val nickname: String,
            val avatar: URI? = null,
            val contacts: List<Contact.Shared.PrimaryContact>,
            val position: Position.Responses.Partial,
        ) : Responsable
    }

    data object Internal {
        @Serializable
        data class Contact(
            var value: String,
            var type: ContactType
        )
    }
}

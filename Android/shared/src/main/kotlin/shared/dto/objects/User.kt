@file:UseSerializers(UUIDSerializer::class, URISerializer::class)

package shared.dto.objects

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.objects.contacts.Contact
import shared.dto.optionSet.MaestriPermissionSet
import shared.dto.optionSet.UserRoleSet
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.URISerializer
import shared.serializers.UUIDSerializer
import java.net.URI
import java.util.*

object User {
    data object Parameters {
        @Serializable
        data class Patch(
            val nickname: String?,
            val avatar: URI?,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Full(
            val id: UUID,
            val avatar: URI?,
            val nickname: String,
            val contacts: List<Contact.Shared.RecoveryContact>,
            val options: UserRoleSet,
            val permissions: MaestriPermissionSet,
            val customerId: UUID? = null,
            val professionalId: UUID? = null,
        ) : Responsable

        @Serializable
        data class Partial(
            val avatar: URI? = null,
            val nickname: String,
        ) : Responsable
    }
}


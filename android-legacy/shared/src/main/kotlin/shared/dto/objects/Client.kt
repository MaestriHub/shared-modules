@file:UseSerializers(UUIDSerializer::class, URISerializer::class)

package shared.dto.objects

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.ContactType
import shared.dto.objects.contacts.Contact
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.URISerializer
import shared.serializers.UUIDSerializer
import java.net.URI
import java.util.*

typealias Clients = List<Client.Responses.ClientInfo>

object Client {
    data object Parameters {
        @Serializable
        data class Create(
            val alias: String,
            val contact: Internal.Contact? = null
        ) : Parametable()

        @Serializable
        data class Retrieve(
            val employees: List<UUID>? = null,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class ClientInfo(
            val id: UUID,
            val user: Internal.UserInfo? = null,
            val alias: String?,
            val contacts: List<Contact.Shared.PrimaryContact>
        ) : Responsable

        @Serializable
        data class Verify(
            val contacts: List<Contact.Shared.PrimaryContact>
        ) : Responsable
    }

    data object Internal {
        @Serializable
        data class Contact(
            val value: String,
            val type: ContactType
        ) : Parametable()

        @Serializable
        data class UserInfo(
            val avatar: URI,
            val nickname: String,
        ) : Parametable()
    }
}

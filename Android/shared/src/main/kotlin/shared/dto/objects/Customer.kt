@file:UseSerializers(UUIDSerializer::class)

package shared.dto.objects

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.ContactType
import shared.dto.enums.CustomerUser
import shared.dto.objects.contacts.Contact
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.UUIDSerializer
import java.util.*

object Customer {
    data object Parameters {
        @Serializable
        data class Registration(
            val contact: Internal.Contact? = null
        ) : Parametable()

        @Serializable
        data class Create(
            val salonId: UUID,
            val alias: String,
            val contact: Internal.Contact? = null
        ) : Parametable()

        @Serializable
        data class Retrieve(
            val salons: List<UUID>? = null,
            val employees: List<UUID>? = null,
        ) : Parametable()

        @Serializable
        data class HandleInvite(
            val contactValue: String? = null
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Full(
            var id: UUID,
            var user: CustomerUser,
            var alias: String? = null,
            var contacts: List<Contact.Shared.PrimaryContact>,
        ) : Responsable

        @Serializable
        data class Partial(
            var id: UUID,
            var user: CustomerUser,
            var alias: String? = null,
            var contacts: List<Contact.Shared.PrimaryContact>,
        ) : Responsable

        @Serializable
        data class Verify(
            var contacts: List<Contact.Shared.PrimaryContact>,
        ) : Responsable
    }
    data object Internal {
        @Serializable
        data class Contact(
            var value: String,
            var type: ContactType
        ) : Parametable()
    }
}

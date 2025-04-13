@file:UseSerializers(
    UUIDSerializer::class,
    URISerializer::class
)
package shared.dto.objects

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.objects.contacts.Contact
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.URISerializer
import shared.serializers.UUIDSerializer
import java.net.URI
import java.util.*

object HandleInvite {
    data object Parameters {
        @Serializable
        data class Customer(
            val contactValue: String? = null,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class EmployeeSuccess(
            val id: UUID,
            val nickname: String,
            val logo: URI,
            val position : String,
        ) : Responsable

        @Serializable
        data class CustomerSuccessOneOff(
            val verify: Internal.Verify,
            val client: Internal.Client,
        ) : Responsable
    }

    data object Internal {
        @Serializable
        data class Verify(
            val contacts: List<Contact.Shared.PrimaryContact>,
        ) : Responsable

        @Serializable
        data class Client(
            val alias: String? = null,
        ) : Responsable
    }
}

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
            val nickname: String? = null,
            val avatar: URI? = null,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class UserInfo(
            val id: UUID,
            val avatar: URI,
            val nickname: String,
            val haveCustomer: Boolean,
            val haveEmployee: Boolean,
        ) : Responsable
    }
}


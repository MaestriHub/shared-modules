@file:UseSerializers(UUIDSerializer::class, URISerializer::class)

package shared.dto.objects

import shared.dto.optionSet.MaestriPermissionSet
import shared.dto.optionSet.UserRoleSet
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.URISerializer
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.net.URI
import java.util.UUID

object User {
    data object Parameters {
        @Serializable
        data class Patch(
            val nickname: String?,
            val avatar: URI?,
            val contact: Contact.Parameters.Create?,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Full(
            val id: UUID,
            val avatar: URI?,
            val nickname: String,
            val contact: Contact.Responses.Full?,
            val options: UserRoleSet,
            val permissions: MaestriPermissionSet,
        ) : Responsable

        @Serializable
        data class Partial(
            val avatar: URI? = null,
            val nickname: String,
        ) : Responsable
    }
}


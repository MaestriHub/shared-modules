@file:UseSerializers(
    UUIDSerializer::class,
    URISerializer::class
)
package shared.dto.objects

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.URISerializer
import shared.serializers.UUIDSerializer
import java.net.URI
import java.util.*

object HandleInvite {
    data object Parameters {
        @Serializable
        data class ClientMerge(
            val contact: String,
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
        data class MaskedContacts(
            val contacts : List<String>,
        ) : Responsable

        @Serializable
        data class ClientMergeSuccess(
            val id: UUID,
            val alias: String? = null,
        ) : Responsable
    }
}

@file:UseSerializers(URISerializer::class)

package shared.dto.objects

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.URISerializer

object Professional {
    data object Parameters {
        @Serializable
        class Create : Parametable()
    }

    data object Responses {
        @Serializable
        data class Partial(
            val user: User.Responses.Partial
        ) : Responsable
    }
}

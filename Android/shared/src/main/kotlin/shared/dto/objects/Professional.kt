@file:UseSerializers(URISerializer::class)

package shared.dto.objects

import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.URISerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers

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

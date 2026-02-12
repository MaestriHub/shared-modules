@file:UseSerializers(UUIDSerializer::class, URISerializer::class)

package shared.dto.objects

import shared.serializers.URISerializer
import java.net.URI

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.protocols.Responsable
import shared.serializers.UUIDSerializer
import java.util.*

object Master {
    data object Responses {
        @Serializable
        data class Salon(
            val id: UUID,
            val nickName: String,
            val logo: URI,
            val position: String,
        ) : Responsable
    }
}

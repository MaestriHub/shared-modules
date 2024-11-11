@file:UseSerializers(UUIDSerializer::class)

package shared.dto.objects

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.SystemType
import shared.dto.enums.VersionType
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.UUIDSerializer
import java.util.*

object Device {
    data object Parameters {
        @Serializable
        data class System(
            val manufacturer: String?,
            val model: String?,
            val system: SystemType?,
            val appVersion: String?,
            val country: String?,
            val fcmToken: String?,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Full(
            val id: UUID,
            val version: VersionType?,
        ) : Responsable
    }
}



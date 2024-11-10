@file:UseSerializers(UUIDSerializer::class)

package shared.dto.objects

import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.SystemType
import shared.dto.enums.VersionType
import java.util.UUID
import javax.print.attribute.standard.PrinterMoreInfoManufacturer

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



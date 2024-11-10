@file:UseSerializers(UUIDSerializer::class, URISerializer::class)

package shared.dto.objects

import shared.dto.enums.SalonType
import shared.dto.primitives.Address
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.URISerializer
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.net.URI
import java.util.UUID

object Salon {
    data object Parameters {
        @Serializable
        data class Create(
            val name: String,
            val type: SalonType,
            val logo: URI?,
            val timeZoneId: String,
            val localeId: String,
            val description: String?,
            val timetable: Timetable.Parameters.Create.Pattern,
            val address: Address,
            var contacts: List<Contact.Parameters.Create>,
        ) : Parametable()

        @Serializable
        data class Patch(
            val name: String?,
            val type: SalonType?,
            val description: String?,
            val logo: URI?,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Full(
            var id: UUID,
            var name: String,
            var type: SalonType,
            var description: String?,
            var logo: URI? = null,
            var address: Address,
            var isActive: Boolean,
            var canEdit: Boolean = false,
            var isFavorite: Boolean = false,
            var localeId: String,
        ) : Responsable

        @Serializable
        data class Partial(
            var id: UUID,
            var name: String,
            var type: SalonType,
            var logo: URI? = null,
            var address: Address,
            var isFavorite: Boolean = false,
        ) : Responsable
    }
}


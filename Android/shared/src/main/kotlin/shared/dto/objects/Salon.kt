@file:UseSerializers(UUIDSerializer::class, URISerializer::class)

package shared.dto.objects

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.SalonType
import shared.dto.primitives.Address
import shared.dto.primitives.CoordinatePoint
import shared.dto.protocols.Responsable
import shared.serializers.URISerializer
import shared.serializers.UUIDSerializer
import java.net.URI
import java.util.*

object Salon {
    data object Responses {
        @Serializable
        data class Full(
            var id: UUID,
            var name: String,
            var type: SalonType,
            var description: String? = null,
            var logo: URI? = null,
            var isActive: Boolean,
            var isFavorite: Boolean = false,
            var localeId: String,
            var timeZoneId: String,
            var address: Address,
            var point: CoordinatePoint,
        ) : Responsable
    }
}
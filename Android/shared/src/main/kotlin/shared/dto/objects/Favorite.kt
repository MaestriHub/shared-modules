@file:UseSerializers(UUIDSerializer::class, URISerializer::class)

package shared.dto.objects

import shared.dto.enums.SalonType
import shared.dto.primitives.Address
import shared.serializers.URISerializer
import java.net.URI

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.primitives.CoordinatePoint
import shared.dto.protocols.Responsable
import shared.serializers.UUIDSerializer
import java.util.*

typealias Salons = List<Salon>

object Favorite {
    data object Responses {

        @Serializable
        data class Salon(
            val id: UUID,
            val name: String,
            val type: SalonType,
            val logo: URI,
            val isActive: Boolean,
            val address: Address,
            val point: CoordinatePoint,
            ) : Responsable
    }
}

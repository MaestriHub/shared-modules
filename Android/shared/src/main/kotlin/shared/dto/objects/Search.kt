@file:UseSerializers(
    UUIDSerializer::class,
    URISerializer::class
)

package shared.dto.objects

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.SalonType
import shared.dto.primitives.Address
import shared.dto.primitives.Pagination
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.URISerializer
import shared.serializers.UUIDSerializer
import java.net.URI
import java.util.*

object Search {
    data object Parameters {
        @Serializable
        data class Retrieve(
            val value: String? = null,
            val salonType: SalonType? = null,
            val latitude: Double? = null,
            val longitude: Double? = null,
            val pagination: Pagination? = null,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Full(
            val suggests: List<Helpers.Suggest>,
            val salons: List<Helpers.Salon>,
        ) : Responsable

        data object Helpers {
            @Serializable
            data class Salon(
                val id: UUID,
                val name: String,
                val type: SalonType,
                val logo: URI,
                val address: Address,
                val isFavorite: Boolean
            ) : Responsable

            @Serializable
            data class Suggest(
                val value: String,
            ) : Responsable
        }
    }
}



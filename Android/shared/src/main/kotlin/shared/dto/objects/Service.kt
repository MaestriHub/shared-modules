@file:UseSerializers(UUIDSerializer::class)

package shared.dto.objects

import shared.dto.enums.ServiceCategory
import shared.dto.primitives.Price
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.UUID

object Service {
    data object Parameters {
        @Serializable
        data class Retrieve(
            val salons: List<UUID>?,
            val employees: List<UUID>?,
            val value: String?,
            val page: Int,
            val per: Int,
        ) : Parametable()

        @Serializable
        data class RetrieveFull(
            val salon: UUID?,
        ) : Parametable()

        @Serializable
        data class Create(
            val title: String,
            val description: String,
            val category: ServiceCategory,
            val language: String?,
        ) : Parametable()

        @Serializable
        data class Patch(
            val title: String?,
            val description: String?,
            val category: ServiceCategory?,
            val language: String,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Full(
            val id: UUID,
            val title: String,
            val description: String,
            val category: ServiceCategory,
            val procedures: List<Procedure.Responses.Full>,
        ) : Responsable

        @Serializable
        data class Partial(
            val id: UUID,
            val title: String,
            val description: String,
            val category: ServiceCategory,
            val minPrice: Price?,
            val minDuration: Int?,
        ) : Responsable

        @Serializable
        data class Micro(
            val id: UUID,
            val title: String,
            val description: String,
            val category: ServiceCategory,
        ) : Responsable
    }
}
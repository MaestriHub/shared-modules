@file:UseSerializers(
    UUIDSerializer::class,
)

package shared.dto.objects.procedure

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.ServiceTags
import shared.dto.primitives.Pagination
import shared.dto.primitives.TranslatedServiceTag
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.UUIDSerializer
import java.util.UUID

object Service {
    data object Parameters {
        @Serializable
        data class All(
            val salonsFilter: List<UUID>? = null,
            val employeesFilter: List<UUID>? = null,
            val valueFilter: String? = null,
            val pagination: Pagination? = null,
        ) : Parametable()

        @Serializable
        data class Create(
            val title: String,
            val tags: Array<ServiceTags>,
        ) : Parametable()

        @Serializable
        data class Update(
            val title: String? = null,
            val tags: Array<ServiceTags>? = null,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Create(
            val id: UUID,
            val title: String,
            val tags: Array<TranslatedServiceTag>,
        ) : Responsable

        @Serializable
        data class Update(
            val id: UUID,
            val title: String,
            val tags: Array<TranslatedServiceTag>,
        ) : Responsable

        @Serializable
        data class All(
            val services: List<Helpers.Service>,
        ) : Responsable

        @Serializable
        data class Retrieve(
            val id: UUID,
            val title: String,
            val tags: Array<TranslatedServiceTag>,
        ) : Responsable

        data object Helpers {

            @Serializable
            data class Service(
                val id: UUID,
                val title: String,
                val tags: Array<TranslatedServiceTag>,
            ) : Responsable
        }
    }
}
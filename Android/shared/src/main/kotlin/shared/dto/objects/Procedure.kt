@file:UseSerializers(UUIDSerializer::class)

package shared.dto.objects

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.primitives.Price
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.UUIDSerializer
import java.util.*

object Procedure {
    data object Parameters {
        @Serializable
        data class Retrieve(
            val salons: List<UUID>?,
            val employees: List<UUID>?,
        ) : Parametable()

        @Serializable
        data class Create(
            val price: Price,
            val duration: Int,
            val description: String?,
            val alias: String?,
            val serviceId: UUID,
            val employeeId: UUID,
        ) : Parametable()

        @Serializable
        data class Patch(
            val priceval: Price?,
            val durationval: Int?,
            val description: String?,
            val alias: String?,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Full(
            val id: UUID,
            val price: Price,
            val duration: Int,
            val description: String?,
            val alias: String?,
            val service: Service.Responses.Micro,
            val master: Employee.Responses.Partial,
        ) : Responsable

        @Serializable
        data class Partial(
            val id: UUID,
            val price: Price,
            val duration: Int,
            val description: String?,
            val alias: String?,
            val service: Service.Responses.Micro,
            val master: Employee.Responses.Partial,
        ) : Responsable
    }
}

@file:UseSerializers(UUIDSerializer::class)

package shared.dto.objects.procedure

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.primitives.Pagination
import shared.dto.primitives.Price
import shared.dto.primitives.TranslatedServiceTag
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.UUIDSerializer
import java.util.*

object Complex {
    data object Parameters {
        @Serializable
        data class All(
            val salonsFilter: Array<UUID>? = null,
            val employeesFilter: Array<UUID>? = null,
            val pagination: Pagination? = null,
        ) : Parametable()

        @Serializable
        data class Create(
            val price: Price,
            val duration: Int,
            val description: String? = null,
            val alias: String? = null,
            val procedure: Array<UUID>? = null,
        ) : Parametable()

        @Serializable
        data class Update(
            val price: Price? = null,
            val duration: Int? = null,
            val description: String? = null,
            val alias: String? = null,
        ) : Parametable()
    }


    data object Responses {

        @Serializable
        data class Create(
            val id: UUID,
            val price: Price,
            val duration: Int,
            val description: String? = null,
            val alias: String? = null,
            val procedure: Array<UUID>,
        ) : Responsable

        @Serializable
        data class Update(
            val id: UUID,
            val price: Price,
            val duration: Int,
            val description: String? = null,
            val alias: String? = null,
        ): Responsable

        @Serializable
        data class All(
            val complexes: Array<Helpers.Complex>,
            val procedures: Array<Helpers.Procedure>,
            val services: Array<Helpers.Service>,
        ): Responsable

        @Serializable
        data class Retrieve(
            val id: UUID,
            val price: Price,
            val duration: Int,
            val description: String? = null,
            val alias: String? = null,
        ): Responsable

        data object Helpers {

            @Serializable
            data class Complex(
                val id: UUID,
                val price: Price,
                val duration: Int,
                val description: String? = null,
                val alias: String? = null,
            ): Responsable

            @Serializable
            data class Procedure(
                val id: UUID,
                val alias: String? = null,
                val description: String? = null,
                val serviceId: UUID,
            ): Responsable

            @Serializable
            data class Service(
                val id: UUID,
                val title: String,
                val tags: Set<TranslatedServiceTag>,
            ): Responsable
        }
    }
}
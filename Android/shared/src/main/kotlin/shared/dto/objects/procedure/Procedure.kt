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

object Procedure {
    data object Parameters {
        @Serializable
        data class Retrieve(
            val salons: List<UUID>? = null,
            val employees: List<UUID>? = null,
        ) : Parametable()

        @Serializable
        data class All(
            val salonsFilter: Array<UUID>? = null,
            val employeeFilter: Array<UUID>? = null,
            val servicesFilter: Array<UUID>? = null,
            val addMasterFilter: Boolean,
            val pagination: Pagination? = null,
        ): Parametable()

        @Serializable
        data class Create(
            val duration: Int,
            val price: Price,
            val description: String? = null,
            val alias: String? = null,
            val serviceId: UUID,
            val employeeId: UUID,
        ): Parametable()

        @Serializable
        data class Update(
            val price: Price? = null,
            val duration: Int? = null,
            val description: String? = null,
            val alias: String? = null,
        ): Parametable()
    }

    data object Responses {
        @Serializable
        data class Create(
            val id: UUID,
            val price: Price,
            val duration: Int,
            val description: String? = null,
            val alias: String? = null,
            val serviceId: UUID,
            val employeeId: UUID,
        ): Responsable

        @Serializable
        data class Update(
            val id: UUID,
            val price: Price,
            val duration: Int,
            val description: String? = null,
            val alias: String? = null,
            val serviceId: UUID,
            val employeeId: UUID,
        ): Responsable

        @Serializable
        data class All(
            val procedures: List<Helpers.Procedure>,
            val services:   List<Helpers.Service>,
            val employees:  List<Helpers.Masters>? = null,
        ): Responsable

        @Serializable
        data class Retrieve(
            val id: UUID,
            val duration: Int,
            val price: Price,
            val alias: String? = null,
            val description: String? = null,
            val serviceId: UUID,
            val employeeId: UUID,
        ): Responsable

        data object Helpers {

            @Serializable
            data class Procedure(
                val id: UUID,
                val duration: Int,
                val price: Price,
                val alias: String? = null,
                val description: String? = null,
                val serviceId: UUID,
            ): Responsable

            @Serializable
            data class Service(
                val id: UUID,
                val tags: List<TranslatedServiceTag>,
                val title: String,
            ): Responsable

            @Serializable
            data class Masters(
                val id: UUID,
                val nickname: String? = null,
                val avatar: String? = null,
            ): Responsable
        }
    }
}

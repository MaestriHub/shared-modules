@file:UseSerializers(
    UUIDSerializer::class,
    URISerializer::class,
    BigDecimalSerializer::class,
    PriceShiftSerializer::class,
)

package shared.dto.objects.procedure

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.ServiceTags
import shared.dto.enums.TranslatedServiceTag
import shared.dto.primitives.Minutes
import shared.dto.primitives.Pagination
import shared.dto.primitives.Price
import java.math.BigDecimal
import shared.dto.primitives.UpdateString
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.BigDecimalSerializer
import shared.serializers.URISerializer
import shared.serializers.UUIDSerializer
import shared.serializers.procedure.PriceShiftSerializer
import java.net.URI
import java.util.*

typealias ChunkPosition = Int
typealias ChunkId = UUID

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
            val alias: String? = null,
            val description: String? = null,
            val priceShift: Helpers.PriceShift,
            val chunks: Array<Helpers.CreateChunkRequest>
        ) : Parametable()

        @Serializable
        data class Update(
            val priceShift: Helpers.PriceShift? = null,
            val description: UpdateString? = null,
            val alias: UpdateString? = null,
            val shuffleChunks: Map<ChunkId, ChunkPosition>? = null,
        ) : Parametable()
    }

    data object Responses {

        @Serializable
        data class Create(
            val id: UUID,
            val priceShift: Helpers.PriceShift,
            val description: String? = null,
            val alias: String? = null,
            val chunks: Array<Helpers.ChunkResponse>,
        ) : Responsable

        @Serializable
        data class Update(
            val id: UUID,
            val description: String? = null,
            val alias: String? = null,
            val priceShift: Helpers.PriceShift,
            val chunks: Array<Helpers.ChunkResponse>,
        ): Responsable

        @Serializable
        data class All(
            val complexes: Array<Helpers.ComplexResponse>,
        ): Responsable

        @Serializable
        data class Retrieve(
            val id: UUID,
            val alias: String? = null,
            val description: String? = null,
            val priceShift: Helpers.PriceShift,
            val chunks: Array<Helpers.ChunkResponse>
        ): Responsable
    }

    data object Helpers {

        @Serializable
        data class CreateChunkRequest(
            val order: Int,
            val proceduresIds: List<UUID>,
        )

        @Serializable
        data class ComplexResponse(
            val id: UUID,
            val alias: String? = null,
            val description: String? = null,
            val priceShift: PriceShift,
            val chunks: Array<ChunkResponse>,
        )

        @Serializable
        data class ChunkResponse(
            val id: UUID,
            val order: Int,
            val procedures: Array<ProcedureResponse>,
            val serviceId: UUID,
            val serviceTitle: String,
            val serviceTags: Array<TranslatedServiceTag>
        )

        @Serializable
        data class ProcedureResponse(
            val id: UUID,
            val alias: String? = null,
            val description: String? = null,
            val masterId: UUID,
            val masterNickname: String,
            val masterAvatar: URI? = null,
            val duration: Minutes,
            val price: Price
        )

        sealed class PriceShift {
            @Serializable
            data class FixedValue(
                val value: BigDecimal,
            ): PriceShift()

            @Serializable
            data class MultiKoeff(
                val value: BigDecimal,
            ): PriceShift()
        }
    }
}
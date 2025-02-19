@file:UseSerializers(
    UUIDSerializer::class,
    URISerializer::class,
    BigDecimalSerializer::class,
    CaseDurationSerializer::class,
    CasePriceSerializer::class,
)

package shared.dto.objects.procedure

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.ServiceTags
import shared.dto.enums.TranslatedServiceTag
import shared.dto.primitives.*
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.URISerializer
import shared.serializers.UUIDSerializer
import java.math.BigDecimal
import shared.serializers.BigDecimalSerializer
import shared.serializers.procedure.CaseDurationSerializer
import shared.serializers.procedure.CasePriceSerializer
import java.net.URI
import java.util.*

object Procedure {
    data object Parameters {
        @Serializable
        data class All(
            val salonsFilter: List<UUID>? = null,
            val employeesFilter: List<UUID>? = null,
            val pagination: Pagination? = null,
        ) : Parametable()

        @Serializable
        data class Create(
            val duration: Minutes,
            val price: Price,
            val description: String? = null,
            val alias: String? = null,
            val parameters: Array<Helpers.CreateParameterRequest>,
            val serviceId: UUID,
            val employeeId: UUID,
        ): Parametable()

        @Serializable
        data class Update(
            val price: Price? = null,
            val duration: Int? = null,
            val description: UpdateString? = null,
            val alias: UpdateString? = null,
        ): Parametable()
    }

    data object Responses {
        @Serializable
        data class Create(
            val procedures: List<Helpers.CreateProcedureResponse>
        ): Responsable

        @Serializable
        data class Update(
            val id: UUID,
            val price: Price,
            val duration: Minutes,
            val description: String? = null,
            val alias: String? = null,
            val serviceId: UUID,
            val serviceTags: ServiceTags,
            val serviceTitle: String,
            val masterId: UUID,
            val masterNickname: String,
            val masterAvatar: URI? = null,
        ): Responsable

        @Serializable
        data class All(
            val procedures: List<Helpers.AllProcedureResponse>,
        ): Responsable

        @Serializable
        data class Retrieve(
            val id: UUID,
            val duration: Minutes,
            val price: Price,
            val alias: String? = null,
            val description: String? = null,
            val parameters: Array<Helpers.ParameterResponse>,
            val serviceId: UUID,
            val serviceTags: Array<TranslatedServiceTag>,
            val serviceTitle: String,
            val masterId: UUID,
            val masterNickname: String,
            val masterAvatar: URI? = null,
        ): Responsable
    }

    data object Helpers {

        @Serializable
        data class CreateParameterRequest(
            val id: UUID,
            val optional: Boolean,
            val cases: Array<CreateCaseRequest>,
        ): Responsable

        @Serializable
        data class CreateCaseRequest(
            val id: Int,
            val casePrice: CasePrice,
            val caseDuration: CaseDuration,
        ): Responsable

        @Serializable
        data class CreateProcedureResponse(
            val id: UUID,
            val duration: Minutes,
            val price: Price,
            val alias: String? = null,
            val description: String? = null,
            val parameters: Array<ParameterResponse>,
            val serviceId: UUID,
            val serviceTags: Array<TranslatedServiceTag>,
            val serviceTitle: String,
            val masterId: UUID,
            val masterNickname: String,
            val masterAvatar: URI? = null,
        ): Responsable


        @Serializable
        data class AllProcedureResponse(
            val id: UUID,
            val duration: Minutes,
            val price: Price,
            val alias: String? = null,
            val description: String? = null,
            val parameters: Array<ParameterResponse>,
            val serviceId: UUID,
            val serviceTags: Array<TranslatedServiceTag>,
            val serviceTitle: String,
            val masterId: UUID,
            val masterNickname: String,
            val masterAvatar: URI? = null,
        )

        @Serializable
        data class ParameterResponse(
            val id: Int,
            val optional: Boolean,
            val title: String,
            val cases: Array<CaseResponse>,
        )

        @Serializable
        data class CaseResponse(
            val id: Int,
            val name: String,
            val price: CasePrice,
            val duration: CaseDuration,
        )

        sealed class CasePrice {
            @Serializable
            data class FixedValue(
                val value: BigDecimal,
            ) : CasePrice()

            @Serializable
            data class MultiKoeff(
                val value: BigDecimal,
            ) : CasePrice()
        }

        sealed class CaseDuration {
            @Serializable
            data class FixedValue(
                val value: BigDecimal,
            ): CaseDuration()

            @Serializable
            data class MultiKoeff(
                val value: BigDecimal,
            ): CaseDuration()
        }
    }
}

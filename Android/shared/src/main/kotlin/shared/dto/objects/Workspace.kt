@file:UseSerializers(
    UUIDSerializer::class,
    URISerializer::class,
    DateISOSerializer::class,
)

package shared.dto.objects

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.ContactType
import shared.dto.enums.SalonType
import shared.dto.primitives.Address
import shared.dto.primitives.CoordinatePoint
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.dto.primitives.Token
import shared.serializers.DateISOSerializer
import shared.serializers.URISerializer
import shared.serializers.UUIDSerializer
import java.net.URI
import java.util.Date
import java.util.UUID

object Workspace {
    data object Parameters {
        @Serializable
        data class Create(
            val name: String,
            val type: SalonType,
            val logo: URI? = null,
            val timeZoneId: String,
            val localeId: String,
            val description: String? = null,
            val contact: Internal.Contact? = null,
            val timetable: Timetable.Parameters.Create.Pattern? = null,
            val address: Address,
            val point: CoordinatePoint,
        ) : Parametable()

        @Serializable
        data class Patch(
            val name: String? = null,
            val type: SalonType? = null,
            val description: String? = null,
            val logo: URI?,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Full(
            var id: UUID,
            var name: String,
            var type: SalonType,
            var description: String? = null,
            var logo: URI,
            var address: Address,
            var point: CoordinatePoint,
            var isActive: Boolean,
            var localeId: String,
            var timeZoneId: String,
            var token: LocalToken,
        ) : Responsable

        @Serializable
        data class LocalToken(
            val value: String,
            val expiration: Date,
        ) : Responsable, Parametable()


        @Serializable
        data class Partial(
            var id: UUID,
            var name: String,
            var type: SalonType,
            var logo: URI,
            var address: Address,
            val point: CoordinatePoint,
            val token: Token,
        ) : Responsable
    }

    data object Internal {
        @Serializable
        data class Contact(
            var value: String,
            var type: ContactType,
        ) : Parametable()
    }
}


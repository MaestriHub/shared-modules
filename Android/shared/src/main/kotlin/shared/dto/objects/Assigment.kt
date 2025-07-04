@file:UseSerializers(
    UUIDSerializer::class,
    DateISOSerializer::class,
    URISerializer::class,
)

package shared.dto.objects

import shared.serializers.DateISOSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.AppointmentStatus
import shared.dto.enums.AppointmentType
import shared.dto.enums.ServiceTags
import shared.dto.objects.contacts.Contact
import shared.dto.primitives.Address
import shared.dto.primitives.CoordinatePoint
import shared.dto.primitives.Price
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.URISerializer
import shared.serializers.UUIDSerializer
import java.net.URI
import java.util.*

object Assigment {
    data object Parameters {
        @Serializable
        data class Retrieve(
            val startDate: Date?,
            val endDate: Date?,
            val employees: List<UUID>?,
            val salons: List<UUID>?,
            val clientId: UUID?
        ) : Parametable()

        @Serializable
        data class Create(
            val clientId: UUID,
            val type: AppointmentType,
            val time: DateInterval,
        ) : Parametable()

        @Serializable
        data class Approve(
            val appointmentsEmployeeId: List<UUID>,
        ) : Parametable()

        @Serializable
        data class Patch(
            val time: DateInterval,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Full(
            val client: Helpers.Client,
            val associative: List<Base>,
            val address: Address,
            val point: CoordinatePoint,
        ) : Responsable

        @Serializable
        data class Partial(
            val client: Helpers.Client,
            val associative: List<Base>,
        ) : Responsable

        @Serializable
        data class Base(
            val id: UUID,
            val status: AppointmentStatus,
            val procedure: Helpers.Procedure,
            val time: DateInterval,
            val price: Price,
        ) : Responsable

        data object Helpers {
            @Serializable
            data class Procedure(
                val id: UUID,
                val description: String? = null,
                val alias: String? = null,
                val master: Master,
                var service: Service
            ) : Responsable

            @Serializable
            data class Service(
                val id: UUID,
                val title: String,
                val category: List<ServiceTags>
            ) : Responsable

            @Serializable
            data class Master(
                val id: UUID,
                val nick: String,
                val avatar: URI,
                val contacts: List<Contact.Shared.PrimaryContact>,
            ) : Responsable

            @Serializable
            data class Client(
                val id: UUID,
                val alias: String,
                val avatar: URI,
                val contacts: List<Contact.Shared.PrimaryContact>,
            ) : Responsable
        }
    }
}
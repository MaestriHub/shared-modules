@file:UseSerializers(
    UUIDSerializer::class,
    DateISOSerializer::class,
    URISerializer::class
)

package shared.dto.objects

import shared.serializers.DateISOSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.AppointmentStatus
import shared.dto.enums.AppointmentType
import shared.dto.enums.ContactType
import shared.dto.enums.ServiceTags
import shared.dto.objects.contacts.Contact
import shared.dto.primitives.Address
import shared.dto.primitives.Price
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.UUIDSerializer
import shared.serializers.URISerializer
import java.util.*
import java.net.URI

object AppointmentCustomer {
    data object Parameters {
        @Serializable
        data class Retrieve(
            val startDate: Date? = null,
            val endDate: Date? = null,
            val employees: List<UUID>? = null,
            val salons: List<UUID>? = null,
        ) : Parametable()

        @Serializable
        data class Create(
            val type: AppointmentType,
            val time: DateInterval,
        ) : Parametable()

        @Serializable
        data class Patch(
            val time: DateInterval,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Full(
            val id: UUID,
            val status: AppointmentStatus,
            val salon: Salon.Responses.Partial,
            val procedures: List<Helpers.Procedure>,
            val time: DateInterval,
            val price: Price,
            val address: Address,
        ) : Responsable

        @Serializable
        data class Partial(
            val id: UUID,
            val status: AppointmentStatus,
            val time: DateInterval,
            val price: Price,
            val procedures: List<Helpers.Procedure>,
        ) : Responsable

        data object Helpers {
            @Serializable
            data class Procedure(
                val id: UUID,
                val description: String?,
                val alias: String?,
                val master: Master,
                var service: Service
            ) : Responsable

            @Serializable
            data class Service(
                val id: UUID,
                val title: String,
                val category: Array<ServiceTags>
            ) : Responsable
            
            @Serializable
            data class Master(
                val id: UUID,
                val nick: String,
                val avatar: URI?,
                val contacts: Array<Contact.Shared.PrimaryContact>,
            ) : Responsable
        }
    }
}

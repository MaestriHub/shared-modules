@file:UseSerializers(
    UUIDSerializer::class
)

package shared.dto.objects.contacts

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.ContactType
import shared.dto.enums.PhoneTypes
import shared.dto.objects.procedure.Complex
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.UUIDSerializer
import java.util.*

typealias ContactId = UUID

object Contact {
    data object Parameters {
        @Serializable
        data class Create(
            val value: String,
            val type: ContactType
        ) : Parametable()

        @Serializable
        data class UpdateContact(
            val setPhoneTypes: PhoneTypes? = null,
        )
    }

    data object Shared {
        // MARK: контакты используемые для восстановления
        @Serializable
        data class RecoveryContact(
            val id: ContactId,
            val value: String,
            val type: ContactType,
        )

        // MARK: контакты используемые для отображения
        @Serializable
        data class PrimaryContact(
            val id: ContactId,
            val value: String,
            val type: ContactType,
            val setPhoneTypes: Set<PhoneTypes>?
        )
    }
}
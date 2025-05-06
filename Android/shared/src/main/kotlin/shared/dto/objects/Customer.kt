@file:UseSerializers(UUIDSerializer::class)

package shared.dto.objects

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.ContactType
import shared.dto.primitives.Token
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.UUIDSerializer

object Customer {
    data object Parameters {
        @Serializable
        data class Registration(
            val contact: Internal.Contact? = null
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Registration(
            val accessToken: Token,
        ) : Responsable
    }
    data object Internal {
        @Serializable
        data class Contact(
            var value: String,
            var type: ContactType
        ) : Parametable()
    }
}

@file:UseSerializers(UUIDSerializer::class)

package shared.dto.objects

import shared.dto.enums.ContactType
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.UUID

object Contact {
    data object Parameters {
        @Serializable
        data class Create(
            val value: String,
            val type: ContactType,
            val isVerify: Boolean?,
        ) : Parametable()

        @Serializable
        data class SendCode(
            val recaptchaToken: String?,
        ) : Parametable()

        @Serializable
        data class Verify(
            val code: String,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class Full(
            val id: UUID,
            val value: String,
            val isVerify: Boolean,
            val type: ContactType,
        ) : Responsable

        @Serializable
        data class Verify(
            val isVerified: Boolean,
        ) : Responsable
    }
}

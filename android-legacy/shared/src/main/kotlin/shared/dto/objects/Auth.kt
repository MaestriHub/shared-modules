@file:UseSerializers(
    UUIDSerializer::class,
    URISerializer::class
)
package shared.dto.objects

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.primitives.Token
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.URISerializer
import shared.serializers.UUIDSerializer
import java.net.URI
import java.util.*

object Auth {
    data object Parameters {
        @Serializable
        data class AppleToken(
            val token: String,
            val firstName: String?,
            val lastName: String?,
            val email: String?,
            val emailVerified: Boolean? = false,
        ) : Parametable()

        @Serializable
        data class GoogleToken(
            val token: String,
            val firstName: String?,
            val lastName: String?,
        ) : Parametable()

        @Serializable
        data class RefreshingToken(
            val token: String,
        ) : Parametable()
    }

    data object Responses {
        @Serializable
        data class SuccessAuth(
            val accessToken: Token,
            val refreshToken: Token,
            val user: Auth.Internal.UserInfo,
        ) : Responsable

        @Serializable
        data class Refresh(
            val accessToken: Token,
            val refreshToken: Token? = null,
        ) : Responsable
    }

    data object Internal {
        @Serializable
        data class UserInfo(
            val id: UUID,
            val avatar: URI? = null,
            val nickname: String? = null,
            val haveCustomer: Boolean,
            val haveEmployee: Boolean,
        ) : Responsable
    }
}

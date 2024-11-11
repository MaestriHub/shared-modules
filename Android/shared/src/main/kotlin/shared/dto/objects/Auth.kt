package shared.dto.objects

import kotlinx.serialization.Serializable
import shared.dto.primitives.Token
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable

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
    }

    data object Responses {
        @Serializable
        data class Full(
            val accessToken: Token,
            val refreshToken: Token,
            val user: User.Responses.Full,
        ) : Responsable

        @Serializable
        data class Partial(
            val accessToken: Token,
            val refreshToken: Token?,
        ) : Responsable
    }
}

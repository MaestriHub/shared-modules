@file:UseSerializers(UUIDSerializer::class)

package shared.dto.objects

import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.UUID

object Device {
    data object Parameters {

        @Serializable
        class Create : Parametable()

        @Serializable
        data class RegisterPush(
            val token: Token,
        ) : Parametable() {
            @Serializable
            sealed class Token {
                @Serializable
                @SerialName("apple")
                data class Apple(
                    val token: String,
                ) : Token()

                @Serializable
                @SerialName("fcm")
                data class Fcm(
                    val token: String,
                ) : Token()
            }
        }
    }

    data object Responses {
        @Serializable
        data class Full(
            val id: UUID,
        ) : Responsable
    }
}



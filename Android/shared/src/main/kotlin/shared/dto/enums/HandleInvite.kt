package shared.dto.enums

import com.maestri.sdk.sources.shared.dto.objects.Customer
import com.maestri.sdk.sources.shared.dto.protocols.Responsable
import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.jsonObject

@Serializable(HandleInvite.Serializer::class)
sealed class HandleInvite : Responsable {
    @Serializable
    data class Success(
        val customer: Customer.Responses.Full,
    ) : HandleInvite()

    @Serializable
    data class Request(
        val verify: Customer.Responses.Verify,
    ) : HandleInvite()

    internal object Serializer :
        JsonContentPolymorphicSerializer<HandleInvite>(HandleInvite::class) {
        override fun selectDeserializer(element: JsonElement): DeserializationStrategy<HandleInvite> {
            return when (element.jsonObject.contains("verify")) {
                true -> Request.serializer()
                false -> Success.serializer()
            }
        }
    }
}

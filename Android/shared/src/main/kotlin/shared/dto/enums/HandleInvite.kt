package shared.dto.enums

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.Serializable
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.jsonObject
import shared.dto.objects.Customer
import shared.dto.protocols.Responsable

@Serializable(HandleInvite.Serializer::class)
sealed class HandleInvite : Responsable {
    @Serializable
    data class Success(
        val successCustomer: Customer.Responses.Full,
    ) : HandleInvite()

    @Serializable
    data class Request(
        val requestVerify: Customer.Responses.Verify,
    ) : HandleInvite()

    internal object Serializer :
        JsonContentPolymorphicSerializer<HandleInvite>(HandleInvite::class) {
        override fun selectDeserializer(element: JsonElement): DeserializationStrategy<HandleInvite> {
            return when (element.jsonObject.contains("requestVerify")) {
                true -> Request.serializer()
                false -> Success.serializer()
            }
        }
    }
}

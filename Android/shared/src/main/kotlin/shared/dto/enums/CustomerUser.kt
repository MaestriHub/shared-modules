@file:UseSerializers(URISerializer::class)

package shared.dto.enums

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.jsonObject
import shared.dto.objects.User
import shared.dto.protocols.Responsable
import shared.serializers.URISerializer
import java.net.URI

@Serializable(CustomerUser.Serializer::class)
sealed class CustomerUser : Responsable {

    @Serializable
    data class Link(
        val link: URI,
    ) : CustomerUser()

    @Serializable
    data class Value(
        val value: User.Responses.Partial,
    ) : CustomerUser()

    internal object Serializer :
        JsonContentPolymorphicSerializer<CustomerUser>(CustomerUser::class) {
        override fun selectDeserializer(element: JsonElement): DeserializationStrategy<CustomerUser> {
            return when (element.jsonObject.contains("link")) {
                true -> Link.serializer()
                false -> Value.serializer()
            }
        }
    }
}
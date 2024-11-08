@file:UseSerializers(URISerializer::class)

package com.maestri.sdk.sources.shared.dto.enums

import com.maestri.sdk.sources.shared.dto.objects.User
import com.maestri.sdk.sources.shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.URISerializer
import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.jsonObject
import java.net.URI

@Serializable(CustomerUser.Serializer::class)
sealed class CustomerUser : Responsable {

    @Serializable
    data class Link(
        val url: URI,
    ) : CustomerUser()

    @Serializable
    data class Value(val customer: User.Responses.Partial) : CustomerUser()

    internal object Serializer :
        JsonContentPolymorphicSerializer<CustomerUser>(CustomerUser::class) {
        override fun selectDeserializer(element: JsonElement): DeserializationStrategy<CustomerUser> {
            return when (element.jsonObject.contains("url")) {
                true -> Link.serializer()
                false -> Value.serializer()
            }
        }
    }
}
@file:UseSerializers(URISerializer::class)

package com.maestri.sdk.sources.shared.dto.enums

import com.maestri.sdk.sources.shared.dto.objects.Professional
import com.maestri.sdk.sources.shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.URISerializer
import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.jsonObject
import java.net.URI

@Serializable(ProfessionalEmployee.Serializer::class)
sealed class ProfessionalEmployee : Responsable {
    @Serializable
    data class Link(
        val url: URI,
    ) : ProfessionalEmployee()

    @Serializable
    data class Value(
        val user: Professional.Responses.Partial,
    ) : ProfessionalEmployee()

    internal object Serializer :
        JsonContentPolymorphicSerializer<ProfessionalEmployee>(ProfessionalEmployee::class) {
        override fun selectDeserializer(element: JsonElement): DeserializationStrategy<ProfessionalEmployee> {
            return when (element.jsonObject.contains("url")) {
                true -> Link.serializer()
                false -> Value.serializer()
            }
        }
    }
}



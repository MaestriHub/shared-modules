@file:UseSerializers(URISerializer::class)

package shared.dto.enums

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.jsonObject
import shared.dto.objects.Professional
import shared.dto.protocols.Responsable
import shared.serializers.URISerializer
import java.net.URI

@Serializable(ProfessionalEmployee.Serializer::class)
sealed class ProfessionalEmployee : Responsable {
    @Serializable
    data class Link(
        val link: URI,
    ) : ProfessionalEmployee()

    @Serializable
    data class Value(
        val value: Professional.Responses.Partial,
    ) : ProfessionalEmployee()

    internal object Serializer :
        JsonContentPolymorphicSerializer<ProfessionalEmployee>(ProfessionalEmployee::class) {
        override fun selectDeserializer(element: JsonElement): DeserializationStrategy<ProfessionalEmployee> {
            return when (element.jsonObject.contains("link")) {
                true -> Link.serializer()
                false -> Value.serializer()
            }
        }
    }
}



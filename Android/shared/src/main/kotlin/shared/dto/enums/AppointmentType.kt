@file:UseSerializers(URISerializer::class)

package shared.dto.enums

import com.maestri.sdk.sources.shared.dto.objects.`User ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Responsable ✅`
import com.maestri.sdk.sources.shared.serializers.URISerializer
import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.jsonObject
import java.net.URI

@Serializable(AppointmentType.Serializer::class)
sealed class AppointmentType : `Responsable ✅` {

    @Serializable
    data class Link(
        val complex: URI,
    ) : AppointmentType()

    @Serializable
    data class Value(
        val customer: `User ✅`.Responses.Partial,
    ) : AppointmentType()

    internal object Serializer :
        JsonContentPolymorphicSerializer<AppointmentType>(AppointmentType::class) {
        override fun selectDeserializer(element: JsonElement): DeserializationStrategy<AppointmentType> {
            return when (element.jsonObject.contains("url")) {
                true -> Link.serializer()
                false -> Value.serializer()
            }
        }
    }
}
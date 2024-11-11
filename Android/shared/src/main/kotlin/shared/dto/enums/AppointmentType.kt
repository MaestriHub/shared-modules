@file:UseSerializers(UUIDSerializer::class)

package shared.dto.enums

import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.jsonObject
import shared.dto.protocols.Responsable
import shared.serializers.UUIDSerializer
import java.util.*

@Serializable(AppointmentType.Serializer::class)
sealed class AppointmentType : Responsable {

    @Serializable
    data class Complex(
        val id: UUID,
    ) : AppointmentType()

    @Serializable
    data class Procedure(
        val id: UUID,
    ) : AppointmentType()

    internal object Serializer :
        JsonContentPolymorphicSerializer<AppointmentType>(AppointmentType::class) {
        override fun selectDeserializer(element: JsonElement): DeserializationStrategy<AppointmentType> {
            return when (element.jsonObject.contains("complex")) {
                true -> Complex.serializer()
                false -> Procedure.serializer()
            }
        }
    }
}
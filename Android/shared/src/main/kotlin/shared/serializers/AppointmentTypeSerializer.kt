package shared.serializers

import shared.dto.enums.AppointmentType

import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerializationException
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.*

object AppointmentTypeSerializer : KSerializer<AppointmentType> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("AppointmentType", PrimitiveKind.STRING)

    override fun serialize(encoder: Encoder, value: AppointmentType) {
        var json: JsonObject

        when(value) {
            is AppointmentType.Procedure -> {
                json = buildJsonObject {
                    put("procedure", value.id.toString())
                }
            }
            is AppointmentType.Complex -> {
                json = buildJsonObject {
                    put("complex", buildJsonObject {
                        put("id", value.id.toString())
                        for ((key, value) in value.order) {
                            put(key.toString(), value.toString())
                        }
                    })
                }
            }
        }

        encoder.encodeSerializableValue(JsonElement.serializer(), json)
    }

    override fun deserialize(decoder: Decoder): AppointmentType {
        throw SerializationException("Мы пока не получаем это никогда")
    }
}
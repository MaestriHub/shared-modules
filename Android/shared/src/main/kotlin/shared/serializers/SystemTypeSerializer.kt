package shared.serializers

import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerializationException
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.*
import shared.dto.enums.SystemType

object SystemTypeSerializer: KSerializer<SystemType> {
    override val descriptor: SerialDescriptor =
        PrimitiveSerialDescriptor("SystemType", PrimitiveKind.STRING)

    override fun deserialize(decoder: Decoder): SystemType {
        throw SerializationException("Мы пока не получаем это никогда")
    }

    override fun serialize(encoder: Encoder, value: SystemType) {
        var type: String = ""
        var version: String = ""

        when(value) {
            is SystemType.Ios -> {
                version = value.version
                type = "ios"
            }
            is SystemType.Android -> {
                version = value.version
                type = "android"
            }
            is SystemType.Chrome -> {
                version = value.version
                type = "chrome"
            }
            is SystemType.Edge -> {
                version = value.version
                type = "edge"
            }
            is SystemType.Firefox -> {
                version = value.version
                type = "firefox"
            }
            is SystemType.Opera -> {
                version = value.version
                type = "opera"
            }
            is SystemType.Safari -> {
                version = value.version
                type = "safari"
            }
        }

        val jsonObject = buildJsonObject {
            putJsonObject(type) {
                put("version", version)
            }
        }

        encoder.encodeSerializableValue(JsonElement.serializer(), jsonObject)
    }
}
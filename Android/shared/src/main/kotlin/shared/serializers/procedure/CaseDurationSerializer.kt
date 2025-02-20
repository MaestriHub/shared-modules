package shared.serializers.procedure

import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerializationException
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.*
import shared.dto.objects.procedure.Procedure
import java.math.BigDecimal

object CaseDurationSerializer : KSerializer<Procedure.Helpers.CaseDuration> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("CaseDuration", PrimitiveKind.STRING)

    override fun serialize(encoder: Encoder, value: Procedure.Helpers.CaseDuration) {
        var json: JsonObject

        when(value) {
            is Procedure.Helpers.CaseDuration.FixedValue -> {
                json = buildJsonObject {
                    put("fixedValue", value.value)
                }
            }
            is Procedure.Helpers.CaseDuration.MultiKoeff -> {
                json = buildJsonObject {
                    put("multiKoeff", value.value)
                }
            }
        }

        encoder.encodeSerializableValue(JsonElement.serializer(), json)
        encoder.encodeString(value.toString())
    }

    override fun deserialize(decoder: Decoder): Procedure.Helpers.CaseDuration {
        val jsonElement = decoder.decodeSerializableValue(JsonElement.serializer())
        if (jsonElement !is JsonObject) {
            throw SerializationException("Invalid JSON format for CaseDuration")
        }

        val type = jsonElement.keys.firstOrNull() ?: throw SerializationException("Type not found in JSON")

        val digitJsonElement = jsonElement[type] ?: throw SerializationException("Digit value not found for type $type")

        if (digitJsonElement !is JsonPrimitive) {
            throw SerializationException("Invalid digit value for type $type")
        }

        if (type == "multiKoeff" && digitJsonElement.doubleOrNull != null) {
            return Procedure.Helpers.CaseDuration.MultiKoeff(BigDecimal(digitJsonElement.double))
        } else if (type == "fixedValue" && digitJsonElement.intOrNull != null) {
            return Procedure.Helpers.CaseDuration.FixedValue(digitJsonElement.int)
        } else {
            throw SerializationException("Unknown type: $type")
        }
    }
}
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
        var digit: BigDecimal = BigDecimal.ZERO
        var type: String = ""

        when(value) {
            is Procedure.Helpers.CaseDuration.FixedValue -> {
                digit = value.value
                type = "fixedValue"
            }
            is Procedure.Helpers.CaseDuration.MultiKoeff -> {
                digit = value.value
                type = "multiKoeff"
            }
        }

        val jsonObject = buildJsonObject {
            put(type, digit)
        }

        encoder.encodeSerializableValue(JsonElement.serializer(), jsonObject)
        encoder.encodeString(value.toString())
    }

    override fun deserialize(decoder: Decoder): Procedure.Helpers.CaseDuration {
        val jsonElement = decoder.decodeSerializableValue(JsonElement.serializer())
        if (jsonElement !is JsonObject) {
            throw SerializationException("Invalid JSON format for CaseDuration")
        }

        val type = jsonElement.keys.firstOrNull() ?: throw SerializationException("Type not found in JSON")

        val digitJsonElement = jsonElement[type] ?: throw SerializationException("Digit value not found for type $type")
        if (digitJsonElement !is JsonPrimitive || digitJsonElement.doubleOrNull != null) {
            throw SerializationException("Invalid digit value for type $type")
        }
        val digit = BigDecimal(digitJsonElement.double)

        return when (type) {
            "fixedValue" -> Procedure.Helpers.CaseDuration.FixedValue(digit)
            "multiKoeff" -> Procedure.Helpers.CaseDuration.MultiKoeff(digit)
            else -> throw SerializationException("Unknown type: $type")
        }
    }
}
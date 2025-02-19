package shared.serializers.procedure

import kotlinx.serialization.KSerializer
import kotlinx.serialization.SerializationException
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import kotlinx.serialization.json.*
import shared.dto.objects.procedure.Complex
import java.math.BigDecimal

object PriceShiftSerializer : KSerializer<Complex.Helpers.PriceShift> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("CasePrice", PrimitiveKind.STRING)

    override fun serialize(encoder: Encoder, value: Complex.Helpers.PriceShift) {
        var digit: BigDecimal = BigDecimal.ZERO
        var type: String = ""

        when(value) {
            is Complex.Helpers.PriceShift.FixedValue -> {
                digit = value.value
                type = "fixedValue"
            }
            is Complex.Helpers.PriceShift.MultiKoeff -> {
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

    override fun deserialize(decoder: Decoder): Complex.Helpers.PriceShift {
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
            "fixedValue" -> Complex.Helpers.PriceShift.FixedValue(digit)
            "multiKoeff" -> Complex.Helpers.PriceShift.MultiKoeff(digit)
            else -> throw SerializationException("Unknown type: $type")
        }
    }
}
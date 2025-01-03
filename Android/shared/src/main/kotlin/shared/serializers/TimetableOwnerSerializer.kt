package shared.serializers

import kotlinx.serialization.KSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import shared.dto.enums.TimetableOwner
import java.util.*

object TimetableOwnerSerializer : KSerializer<TimetableOwner> {
    override val descriptor: SerialDescriptor = PrimitiveSerialDescriptor("TimetableOwner", PrimitiveKind.STRING)

    override fun serialize(encoder: Encoder, value: TimetableOwner) {
        encoder.encodeString(value.description)
    }

    override fun deserialize(decoder: Decoder): TimetableOwner {
        val description = decoder.decodeString()
        val parts = description.split(":")
        if (parts.size != 2) {
            throw IllegalArgumentException("Invalid TimetableOwner description: $description")
        }
        val type = parts[0]
        val id = try {
            UUID.fromString(parts[1])
        } catch (e: IllegalArgumentException) {
            throw IllegalArgumentException("Invalid UUID in TimetableOwner description: $description", e)
        }

        return when (type) {
            "salon" -> TimetableOwner.Salon(id)
            "employee" -> TimetableOwner.Employee(id)
            else -> throw IllegalArgumentException("Unknown TimetableOwner type: $type")
        }
    }
}
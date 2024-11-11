package shared.serializers

import kotlinx.serialization.KSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import shared.dto.optionSet.PermissionSet

object PermissionSetSerializer : KSerializer<PermissionSet> {
    override val descriptor: SerialDescriptor =
        PrimitiveSerialDescriptor("PermissionSet", PrimitiveKind.INT)

    override fun deserialize(decoder: Decoder): PermissionSet {
        return PermissionSet(decoder.decodeInt())
    }

    override fun serialize(encoder: Encoder, value: PermissionSet) {
        encoder.encodeString(value.toString())
    }
}
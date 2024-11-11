package shared.serializers

import kotlinx.serialization.KSerializer
import kotlinx.serialization.descriptors.PrimitiveKind
import kotlinx.serialization.descriptors.PrimitiveSerialDescriptor
import kotlinx.serialization.descriptors.SerialDescriptor
import kotlinx.serialization.encoding.Decoder
import kotlinx.serialization.encoding.Encoder
import shared.dto.optionSet.UserRoleSet

object UserRoleSetSerializer : KSerializer<UserRoleSet> {
    override val descriptor: SerialDescriptor =
        PrimitiveSerialDescriptor("UserRoleSet", PrimitiveKind.INT)

    override fun deserialize(decoder: Decoder): UserRoleSet {
        return UserRoleSet(decoder.decodeInt())
    }

    override fun serialize(encoder: Encoder, value: UserRoleSet) {
        encoder.encodeString(value.toString())
    }
}
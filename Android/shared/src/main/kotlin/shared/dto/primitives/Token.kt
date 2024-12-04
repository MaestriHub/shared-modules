package shared.dto.primitives

import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.protocols.Responsable
import java.util.*

@Serializable
data class Token(
        val value: String,
        @Contextual
        val expiration: Date,
) : Responsable
package shared.dto.primitives

import kotlinx.serialization.Serializable
import shared.dto.enums.ServiceTags
import shared.dto.protocols.Responsable

@Serializable
data class TranslatedServiceTag(
    val key: ServiceTags,
    val translate: String
) : Responsable
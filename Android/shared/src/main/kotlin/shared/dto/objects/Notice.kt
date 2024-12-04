@file:UseSerializers(
    UUIDSerializer::class,
    DateISOSerializer::class
)

package shared.dto.objects

import shared.serializers.DateISOSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.NoticeCategory
import shared.dto.protocols.Responsable
import shared.serializers.UUIDSerializer
import java.util.*

object Notice {
    data object Responses {
        @Serializable
        data class Full(
            val id: UUID,
            val titleKey: String,
            val messageKey: String,
            val parameters: String?,
            val category: NoticeCategory,
            val isRead: Boolean,
            val date: Date?,
        ) : Responsable
    }
}

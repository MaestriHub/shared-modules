@file:UseSerializers(UUIDSerializer::class, DateSerializer::class)

package shared.dto.objects

import shared.dto.enums.NoticeCategory
import shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.DateSerializer
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.Date
import java.util.UUID

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

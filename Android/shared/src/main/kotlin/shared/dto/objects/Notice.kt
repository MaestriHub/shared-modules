@file:UseSerializers(UUIDSerializer::class, DateSerializer::class)

package com.maestri.sdk.sources.shared.dto.objects

import shared.dto.enums.`NoticeCategory ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Responsable ✅`
import com.maestri.sdk.sources.shared.serializers.DateSerializer
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.Date
import java.util.UUID

/// Пространство имен `Notice` содержит типы данных для работы с информацией о клиентах.
///
/// В него входят  модели ответов (`Responses`),
/// используемые для обмена данными между клиентом и сервером в контексте клиентских данных.
object Notice {
    // MARK: - Responses -
    data object Responses {
        /// Полная информация об уведомлении.
        /// Включает в себя всю необходимую информацию об уведомлении, которое может быть представлено пользователю.
        ///
        /// ### Properties:
        /// - `id`: Уникальный идентификатор уведомления.
        /// - `title`: Заголовок уведомления, предоставляющий краткую суть сообщения.
        /// - `body`: Основное содержимое уведомления, которое переносит детальную информацию.
        /// - `date`: Дата и время создания уведомления, может быть `nil`, если дата не предоставляется.
        @Serializable
        data class Full(
            val id: UUID,
            val titleKey: String,
            val messageKey: String,
            val parameters: String?,
            val category: `NoticeCategory ✅`,
            val isRead: Boolean,
            val date: Date?,
        ) : `Responsable ✅`
    }
}

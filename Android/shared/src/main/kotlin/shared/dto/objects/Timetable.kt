@file:UseSerializers(UUIDSerializer::class, DateSerializer::class)

package DTOs.objects

import com.maestri.sdk.sources.shared.dto.objects.DateInterval
import com.maestri.sdk.sources.shared.dto.primitives.Schedule
import com.maestri.sdk.sources.shared.dto.protocols.Parametable
import com.maestri.sdk.sources.shared.dto.protocols.Responsable
import com.maestri.sdk.sources.shared.serializers.DateSerializer
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.Date
import java.util.UUID

/// Пространство имен `Timetable` содержит типы данных для взаимодействия с информацией о салонах красоты.
///
/// Включает параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обработки данных о салонах в системе.
object Timetable {
    // MARK: - Parameters -
    data object Parameters {
        /// Параметры запроса для поиска доступных временных слотов для процедур.
        /// Учитывает часовой пояс и список запрашиваемых процедур.
        ///
        /// ### Properties:
        /// - `procedures`: Список идентификаторов процедур, для которых ищутся слоты.
        @Serializable
        data class SearchSlot(
            val procedures: List<UUID>,
        ) : Parametable()
    }

    // MARK: - Responses -
    data object Responses {
        /// Структура ответа, возвращающая доступные временные слоты.
        /// Представляет доступные интервалы для записи к мастеру или в салоне на ближайшие дни.
        ///
        /// ### Properties:
        /// - `days`: Словарь, сопоставляющий даты с массивами доступных временных интервалов.
        @Serializable
        data class Slot(
            val intervals: Map<Date, List<DateInterval>>,
            val timeZone: String,
        ) : Responsable


        @Serializable
        data class Week(
            val schedule: Schedule.Week,
            val timeZone: String,
        ) : Parametable(), Responsable
    }
}

@file:UseSerializers(UUIDSerializer::class, DateSerializer::class)

package shared.dto.objects

import com.maestri.sdk.sources.shared.dto.enums.TimetableOwner
import shared.dto.primitives.`Schedule ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Parametable ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Responsable ✅`
import com.maestri.sdk.sources.shared.serializers.DateSerializer
import com.maestri.sdk.sources.shared.serializers.UUIDSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.AppointmentType
import java.util.Date
import java.util.UUID

typealias Intervals = List<`DateInterval ✅`>

/// Пространство имен `Timetable` содержит типы данных для взаимодействия с информацией о салонах красоты.
///
/// Включает параметры для запросов (`Parameters`) и модели ответов (`Responses`),
/// используемые для обработки данных о салонах в системе.
object `Timetable ✅` {
    // MARK: - Parameters -
    data object Parameters {
        data object Create {
            @Serializable
            data class Pattern(
                val schedule: `Schedule ✅`.Pattern,
                val startAt: Date,
                val endAt: Date?,
            ) : `Parametable ✅`()

            @Serializable
            data class Flexible(
                val workDays: Map<Date, `Schedule ✅`.Day>
            ) : `Parametable ✅`()
        }

        @Serializable
        data class SearchSlot(
            val appointmentType: AppointmentType,
            val customerId: UUID?,
        ) : `Parametable ✅`()

        @Serializable
        data class Retrieve(
            val owners: List<TimetableOwner>,
            //Идеально отправлять в salon time zone с 00:00-00:00 чтобы были только дни
            val period: `DateInterval ✅`,
        ) : `Parametable ✅`()
    }

    // MARK: - Responses -
    data object Responses {
        // Используется для возвращения найденных слотов на которые можно записаться
        @Serializable
        data class Slots(
            val intervals: Intervals,
            val timeZoneId: String,
        ) : `Responsable ✅`

        @Serializable
        data class Schedule(
            val owner: TimetableOwner,
            //для недели 7 дней для месяца 28-31
            val intervals: Intervals,
            val timeZoneId: String,
        ) : `Responsable ✅`
    }
}

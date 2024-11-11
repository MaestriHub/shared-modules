@file:UseSerializers(UUIDSerializer::class, DateSerializer::class, TimetableOwnerSerializer::class)

package shared.dto.objects

import com.maestri.sdk.sources.shared.serializers.DateSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import shared.dto.enums.AppointmentType
import shared.dto.enums.TimetableOwner
import shared.dto.primitives.Schedule
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import shared.serializers.TimetableOwnerSerializer
import shared.serializers.UUIDSerializer
import java.util.*

typealias Intervals = List<DateInterval>

object Timetable {
    data object Parameters {
        data object Create {
            @Serializable
            data class Pattern(
                val schedule: Schedule.Pattern,
                val startAt: Date,
                val endAt: Date?,
            ) : Parametable()

            @Serializable
            data class Flexible(
                val workDays: Map<Date, Schedule.Day>
            ) : Parametable()
        }

        @Serializable
        data class SearchSlot(
            val appointmentType: AppointmentType,
            val customerId: UUID?,
        ) : Parametable()

        @Serializable
        data class Retrieve(
            val owners: List<TimetableOwner>,
            //Идеально отправлять в salon time zone с 00:00-00:00 чтобы были только дни
            val period: DateInterval,
        ) : Parametable()
    }

    data object Responses {
        // Используется для возвращения найденных слотов на которые можно записаться
        @Serializable
        data class Slots(
            val intervals: Intervals,
            val timeZoneId: String,
        ) : Responsable

        @Serializable
        data class Schedule(
            val owner: TimetableOwner,
            //для недели 7 дней для месяца 28-31
            val intervals: Intervals,
            val timeZoneId: String,
        ) : Responsable
    }
}

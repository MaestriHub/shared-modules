@file:UseSerializers(DateSerializer::class)

package shared.dto.primitives

import com.maestri.sdk.sources.shared.dto.protocols.`Parametable ✅`
import com.maestri.sdk.sources.shared.dto.protocols.`Responsable ✅`
import com.maestri.sdk.sources.shared.serializers.DateSerializer
import kotlinx.serialization.Serializable
import kotlinx.serialization.UseSerializers
import java.util.*

object Schedule {

    // добавить Pattern

    /// WorkSchedule: расписание которое содержит в себе одну неделю
    @Serializable
    data class Week(
        val monday: Day? = null,
        val tuesday: Day? = null,
        val wednesday: Day? = null,
        val thursday: Day? = null,
        val friday: Day? = null,
        val saturday: Day? = null,
        val sunday: Day? = null,
    ) : `Parametable ✅`(), `Responsable ✅`

    @Serializable
    data class Cycled(
        val startDay: Date,
        val workDays: Dictionary<Int, Day>, //добавить сериализатор или разобраться
        val restDays: Int,
    ) : `Parametable ✅`(), `Responsable ✅`

    /// DaySchedule: модель одного дня в расписании
    @Serializable
    data class Day(
        val workTime: String,
        val offTime: List<String>,
    ) : `Parametable ✅`(), `Responsable ✅`
}

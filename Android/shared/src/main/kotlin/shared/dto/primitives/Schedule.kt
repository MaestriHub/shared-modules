@file:UseSerializers(DateSerializer::class)

package shared.dto.primitives

import com.maestri.sdk.sources.shared.serializers.DateSerializer
import kotlinx.serialization.DeserializationStrategy
import kotlinx.serialization.Serializable
import kotlinx.serialization.SerializationException
import kotlinx.serialization.UseSerializers
import kotlinx.serialization.json.JsonContentPolymorphicSerializer
import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.jsonObject
import shared.dto.protocols.Parametable
import shared.dto.protocols.Responsable
import java.util.*

object Schedule {
    @Serializable(Pattern.Serializer::class)
    sealed class Pattern : Responsable {
        @Serializable
        data class Weekly(
            val week: Schedule.Week,
        ) : Pattern()

        @Serializable
        data class Cycled(
            val cycle: Schedule.Cycled,
        ) : Pattern()

        @Serializable
        data class Daily(
            val day: Schedule.Day,
        ) : Pattern()

        internal object Serializer :
            JsonContentPolymorphicSerializer<Pattern>(Pattern::class) {
            override fun selectDeserializer(element: JsonElement): DeserializationStrategy<Pattern> {
                val keys = element.jsonObject.keys
                return when {
                    "week" in keys -> Weekly.serializer()
                    "cycle" in keys -> Cycled.serializer()
                    "day" in keys -> Daily.serializer()
                    else -> throw SerializationException("Unknown pattern type")
                }
            }
        }
    }

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
    ) : Parametable(), Responsable

    @Serializable
    data class Cycled(
        val startDay: Date,
        val workDays: Map<Int, Day>,
        val restDays: Int,
    ) : Parametable(), Responsable

    /// DaySchedule: модель одного дня в расписании
    @Serializable
    data class Day(
        val workTime: String,
        val offTime: List<String>,
    ) : Parametable(), Responsable
}

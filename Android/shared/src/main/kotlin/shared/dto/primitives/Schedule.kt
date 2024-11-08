package com.maestri.sdk.sources.shared.dto.primitives

import com.maestri.sdk.sources.shared.dto.protocols.Parametable
import com.maestri.sdk.sources.shared.dto.protocols.Responsable
import kotlinx.serialization.Serializable

object Schedule {

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

    /// DaySchedule: модель одного дня в расписании
    @Serializable
    data class Day(
        val workTime: String,
        val offTime: List<String>,
    ) : Parametable(), Responsable
}

package shared.dto.enums

import kotlinx.serialization.SerialName

/// Описывает тип Операции (пока финансы особо не работают)
/// - `APPOINTMENT`: Операция связанная с аппоинтментом
/// - `SALARY`     : Операция связанная с зарплатой
/// - `OTHER`      : "Какая-то" операция
enum class `OperationType ✅` {
    @SerialName("appointment")
    APPOINTMENT,

    @SerialName("salary")
    SALARY,

    @SerialName("other")
    OTHER,
}

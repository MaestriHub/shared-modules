package shared.dto.enums

import kotlinx.serialization.SerialName

/// Описывает категорию уведомлений
/// - `APPOINTMENT`: Уведомления о рабочих аппоинтментах
/// - `ASSIGNMENT`: Уведомления о кастомерских аппоинтментах
/// - `EMPLOYEE`            : Уведомления рабочему (мб оверхед)
/// - `POSITION`            : Уведомления о изменении позиции
/// - `SALARY`              : Уведомления о зарплате
/// - `SUGGEST`             : Предложение о смерживании контактов
enum class NoticeCategory {
    @SerialName("appointment")
    APPOINTMENT,

    @SerialName("assignment")
    ASSIGNMENT,

    @SerialName("employee")
    EMPLOYEE,

    @SerialName("position")
    POSITION,

    @SerialName("salary")
    SALARY,

    @SerialName("suggest")
    SUGGEST,
}

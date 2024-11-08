package shared.dto.enums

import kotlinx.serialization.SerialName

/// Описывает категорию уведомлений
/// - `APPOINTMENT_EMPLOYEE`: Уведомления о рабочих аппоинтментах
/// - `APPOINTMENT_CUSTOMER`: Уведомления о кастомерских аппоинтментах
/// - `EMPLOYEE`            : Уведомления рабочему (мб оверхед)
/// - `POSITION`            : Уведомления о изменении позиции
/// - `SALARY`              : Уведомления о зарплате
/// - `SUGGEST`             : Предложение о смерживании контактов
enum class `NoticeCategory ✅` {
    @SerialName("appointmentEmployee")
    APPOINTMENT_EMPLOYEE,

    @SerialName("appointmentCustomer")
    APPOINTMENT_CUSTOMER,

    @SerialName("employee")
    EMPLOYEE,

    @SerialName("position")
    POSITION,

    @SerialName("salary")
    SALARY,

    @SerialName("suggest")
    SUGGEST,
}

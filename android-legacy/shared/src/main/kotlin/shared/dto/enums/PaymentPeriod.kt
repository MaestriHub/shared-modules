package shared.dto.enums

import kotlinx.serialization.SerialName

/// Описывает частоту выплат
/// - `MONTH`: Раз в месяц
/// - `DAY`  : Раз в день
/// - `HOUR` : Раз в час
enum class PaymentPeriod {
    @SerialName("month")
    MONTH,

    @SerialName("day")
    DAY,

    @SerialName("hour")
    HOUR,
}
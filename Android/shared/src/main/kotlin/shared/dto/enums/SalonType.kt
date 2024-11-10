package shared.dto.enums

import kotlinx.serialization.SerialName

/// Описывает тип Салона
/// - `INDIVIDUAL`: Индивидуальное предприятие
/// - `CHAIN`     : Сеть салонов
/// - `MASTER`    : Самозанятый мастер
enum class SalonType {
    @SerialName("individual")
    INDIVIDUAL,

    @SerialName("chain")
    CHAIN,

    @SerialName("master")
    MASTER
}

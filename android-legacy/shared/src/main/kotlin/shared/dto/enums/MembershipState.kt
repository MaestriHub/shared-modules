package shared.dto.enums

import kotlinx.serialization.SerialName

/// Описывает состояние подписки
/// - `ACTIVE`  : Подписка активна
/// - `CANCEL`  : Подписка отменена
/// - `INACTIVE`: Подписка неактивна
enum class MembershipState {
    @SerialName("active")
    ACTIVE,

    @SerialName("cancel")
    CANCEL,

    @SerialName("inactive")
    INACTIVE,
}

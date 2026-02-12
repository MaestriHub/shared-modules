package shared.dto.enums

import kotlinx.serialization.SerialName

/// Описывает тип выплаты
/// - `BANK_TRANSFER`: Банковский перевод
/// - `REAL`         : Кеш
/// - `CRYPT`        : Криптовалюта
enum class PaymentType {
    @SerialName("bankTransfer")
    BANK_TRANSFER,

    @SerialName("real")
    REAL,

    @SerialName("crypt")
    CRYPT,
}
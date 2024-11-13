/// Описывает тип выплаты
/// - `BANK_TRANSFER`: Банковский перевод
/// - `REAL`         : Кеш
/// - `CRYPT`        : Криптовалюта
enum PaymentType {
    BANK_TRANSFER = "bankTransfer",
    REAL = "real",
    CRYPT = "crypt",
}
package shared.dto.enums

import kotlinx.serialization.SerialName

/// Описывает поддерживаемые типы контактных данных.
/// - `PHONE`    : Телефонный номер.
/// - `EMAIL`    : Электронная почта.
/// - `TELEGRAM` : Идентификатор Telegram.
/// - `WHATSAPP` : Идентификатор WhatsApp.
/// - `INSTAGRAM`: Идентификатор Instagram.
/// - `MESSAGE`  : Сообщение в приложении
enum class ContactType {
    @SerialName("phone")
    PHONE,

    @SerialName("email")
    EMAIL,

    @SerialName("telegram")
    TELEGRAM,

    @SerialName("whatsapp")
    WHATSAPP,

    @SerialName("instagram")
    INSTAGRAM,

    @SerialName("message")
    MESSAGE,
}

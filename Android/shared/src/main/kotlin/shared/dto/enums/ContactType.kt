package shared.dto.enums

import kotlinx.serialization.SerialName

enum class ContactType {
    @SerialName("phone")
    PHONE,

    @SerialName("email")
    EMAIL,

    @SerialName("telegram")
    TELEGRAM,

    @SerialName("instagram")
    INSTAGRAM,
}

enum class PhoneTypes {
    @SerialName("whatsapp")
    WHATSAPP,

    @SerialName("message")
    MESSAGE,

    @SerialName("call")
    CALL,
}
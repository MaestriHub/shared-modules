package shared.dto.enums

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

/// Описывает категории всех сервисов
/// - `NAILS`          : Ногти
/// - `MASSAGE`        : Массаж
/// - `SPA`            : Спа
/// - `COSMETOLOGY`    : Косметология
/// - `HAIRDRESSING`   : Парикмахерские услуги
/// - `EPILATION`      : Эпиляция
/// - `PIERCING`       : Пирсинг
/// - `MAKEUP`         : Мейкап
/// - `BROWS`          : Брови
/// - `LASHES`         : Ресницы
/// - `BARBERSHOP`     : Барбершоп
/// - `PERMANENTMAKEUP`: Перманентный макияж
enum class ServiceTags {
    @SerialName("nails")
    NAILS,

    @SerialName("massage")
    MASSAGE,

    @SerialName("spa")
    SPA,

    @SerialName("cosmetology")
    COSMETOLOGY,

    @SerialName("hairdressing")
    HAIRDRESSING,

    @SerialName("epilation")
    EPILATION,

    @SerialName("piercing")
    PIERCING,

    @SerialName("makeup")
    MAKEUP,

    @SerialName("brows")
    BROWS,

    @SerialName("lashes")
    LASHES,

    @SerialName("barbershop")
    BARBERSHOP,

    @SerialName("permanent makeup")
    PERMANENTMAKEUP,
}

@Serializable
data class TranslatedServiceTag(
    val tag: ServiceTags,
    val translate: String
)

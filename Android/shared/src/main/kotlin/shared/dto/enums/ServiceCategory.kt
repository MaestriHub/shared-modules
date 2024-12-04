package shared.dto.enums

import kotlinx.serialization.SerialName

/// Описывает категории всех сервисов
/// - `NAILS`       : Ногти
/// - `MASSAGE`     : Массаж
/// - `SPA`         : Спа
/// - `COSMETOLOGY` : Косметология
/// - `HAIRDRESSING`: Парикмахерские услуги
/// - `EPILATION`   : Эпиляция
/// - `DEPILATION`  : Депиляция
/// - `TATTOO`      : Тату
/// - `PIERCING`    : Пирсинг
/// - `MAKEUP`      : Мейкап
/// - `BROWS`       : Брови
/// - `LASHES`      : Ресницы
/// - `OTHER`       : Остальное

enum class ServiceCategory {
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

    @SerialName("depilation")
    DEPILATION,

    @SerialName("tattoo")
    TATTOO,

    @SerialName("piercing")
    PIERCING,

    @SerialName("makeup")
    MAKEUP,

    @SerialName("brows")
    BROWS,

    @SerialName("lashes")
    LASHES,

    @SerialName("other")
    OTHER,
}


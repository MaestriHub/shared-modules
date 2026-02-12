package shared.dto.enums

import kotlinx.serialization.SerialName

///  VersionType возвращает тип версии вашего api клиента
///
/// - `LATEST`     : Последняя
/// - `STABLE`     : Рабочая но лучше обновиться
/// - `UNSUPPORTED`: Неподдерживаемая
enum class VersionType {
    @SerialName("latest")
    LATEST,

    @SerialName("stable")
    STABLE,

    @SerialName("unsupported")
    UNSUPPORTED,
}

///  VersionType возвращает тип версии вашего api клиента
///
/// - `LATEST`     : Последняя
/// - `STABLE`     : Рабочая но лучше обновиться
/// - `UNSUPPORTED`: Неподдерживаемая
export enum VersionType {
    LATEST = "latest",
    STABLE = "stable",
    UNSUPPORTED = "unsupported",
}

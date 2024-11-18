///  VersionType возвращает тип версии вашего api клиента
///
/// - `LATEST`     : Последняя
/// - `STABLE`     : Рабочая но лучше обновиться
/// - `UNSUPPORTED`: Неподдерживаемая
export enum VersionType {
    latest = "latest",
    stable = "stable",
    unsupported = "unsupported",
}

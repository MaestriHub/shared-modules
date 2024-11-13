/// Описывает тип Операции (пока финансы особо не работают)
/// - `APPOINTMENT`: Операция связанная с аппоинтментом
/// - `SALARY`     : Операция связанная с зарплатой
/// - `OTHER`      : "Какая-то" операция
export enum OperationType {
    APPOINTMENT = "appointment",
    SALARY = "salary",
    OTHER = "other",
}

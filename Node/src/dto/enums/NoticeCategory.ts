/// Описывает категорию уведомлений
/// - `APPOINTMENT_EMPLOYEE`: Уведомления о рабочих аппоинтментах
/// - `APPOINTMENT_CUSTOMER`: Уведомления о кастомерских аппоинтментах
/// - `EMPLOYEE`            : Уведомления рабочему (мб оверхед)
/// - `POSITION`            : Уведомления о изменении позиции
/// - `SALARY`              : Уведомления о зарплате
/// - `SUGGEST`             : Предложение о смерживании контактов
export enum NoticeCategory {
    appointmentEmployee = "appointmentEmployee",
    appointmentCustomer = "appointmentCustomer",
    employee = "employee",
    position = "position",
    salary = "salary",
    suggest = "suggest",
}

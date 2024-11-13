/// Описывает категорию уведомлений
/// - `APPOINTMENT_EMPLOYEE`: Уведомления о рабочих аппоинтментах
/// - `APPOINTMENT_CUSTOMER`: Уведомления о кастомерских аппоинтментах
/// - `EMPLOYEE`            : Уведомления рабочему (мб оверхед)
/// - `POSITION`            : Уведомления о изменении позиции
/// - `SALARY`              : Уведомления о зарплате
/// - `SUGGEST`             : Предложение о смерживании контактов
enum NoticeCategory {
    APPOINTMENT_EMPLOYEE = "appointmentEmployee",
    APPOINTMENT_CUSTOMER = "appointmentCustomer",
    EMPLOYEE = "employee",
    POSITION = "position",
    SALARY = "salary",
    SUGGEST = "suggest",
}

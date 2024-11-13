///  Описывает состояние Appointment
///  Поле: AppointmentEmployee | AppointmentCustomer
///
/// - `BOTH_APPROVED`    : Все участники Appointment подтвердили запрос
/// - `CUSTOMER_DECLINED`: Customer отменил Appointment
/// - `MASTER_DECLINED`  : Какой-то Employee отменил Appointment
/// - `MASTER_APPROVED`  : (AppointmentEmployee) соответствующий Employee подтвердил участие
/// - `CUSTOMER_APPROVED`: (AppointmentCustomer) соответствующий Customer подтвердил участие
/// - `REQUESTED`        : соответствующий Employee/Customer не подтвердил свое участие
export enum AppointmentStatus {
    REQUESTED = "requested",
    CUSTOMER_APPROVED = "customerApproved",
    MASTER_APPROVED = "masterApproved",
    BOTH_APPROVED = "bothApproved",
    CUSTOMER_DECLINED = "customerDeclined",
    MASTER_DECLINED = "masterDeclined",
}
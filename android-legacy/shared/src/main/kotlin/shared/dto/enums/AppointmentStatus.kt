package shared.dto.enums

import kotlinx.serialization.SerialName

///  Описывает состояние Appointment
///  Поле: AppointmentEmployee | AppointmentCustomer
///
/// - `BOTH_APPROVED`    : Все участники Appointment подтвердили запрос
/// - `CUSTOMER_DECLINED`: Customer отменил Appointment
/// - `MASTER_DECLINED`  : Какой-то Employee отменил Appointment
/// - `MASTER_APPROVED`  : (AppointmentEmployee) соответствующий Employee подтвердил участие
/// - `CUSTOMER_APPROVED`: (AppointmentCustomer) соответствующий Customer подтвердил участие
/// - `REQUESTED`        : соответствующий Employee/Customer не подтвердил свое участие
enum class AppointmentStatus {
    @SerialName("requested")
    REQUESTED,

    @SerialName("customer_approved")
    CUSTOMER_APPROVED,

    @SerialName("master_approved")
    MASTER_APPROVED,

    @SerialName("both_approved")
    BOTH_APPROVED,

    @SerialName("customer_declined")
    CUSTOMER_DECLINED,

    @SerialName("master_declined")
    MASTER_DECLINED,
}

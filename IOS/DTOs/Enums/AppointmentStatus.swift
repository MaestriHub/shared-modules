import Foundation

/// `AppointmentStatus` описывает состояние appoinment
///
/// Используется для понимание кто отклонил или подтвердил
/// Так же отображает состояние успешно ли завершился или провалился
public enum AppointmentStatus: String, Codable, Hashable, Equatable {

    /// Этот статус ожидает подтверждения либо перехода по ссылки аттача customer и approve
    case requested
    /// Те кто подтвердили запись: `customer_approved` или `master_approved` или `both_approved`
    /// Так же этот статус подойдёт для отображение того
    /// что запись завершена успешно если `approved_all` и время процедуры уже прошло
    case customerApproved = "customer_approved"
    case masterApproved = "master_approved"
    case bothApproved = "both_approved"
    /// Те кто отклонил запись: `customer_declined` или `master_declined`
    /// Так же этот статус подойдёт для отображение того
    /// что кто то не пришёл на процедуру и время процедуры уже прошло
    case customerDeclined = "customer_declined"
    case masterDeclined = "master_declined"
}

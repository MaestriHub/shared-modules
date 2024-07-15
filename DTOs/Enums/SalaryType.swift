import Foundation

public enum SalaryType: Codable, Hashable, Equatable {
    public enum PaymentPeriod: Codable {
        case day
        case month
        case hour
    }

    public enum PaymentType: Codable, Hashable {
        case procent(procent: Decimal)
        case value(value: Decimal)
    } 

    case procent(Decimal)
    case grid(proceduresMap: [UUID : PaymentType])
    case wage(price: Price, period: PaymentPeriod)
    case none
}
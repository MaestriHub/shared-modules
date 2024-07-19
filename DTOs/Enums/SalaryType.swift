import Foundation

public enum SalaryType: Codable, Hashable, Equatable {
    public enum PaymentPeriod: Codable {
        case day
        case month
        case hour
    }

    public enum PaymentType: Codable, Hashable {
        case procent(procent: UInt)
        case value(value: Price)
    } 

    case procent(value: UInt)
    case grid(proceduresMap: [UUID : PaymentType])
    case wage(price: Price, period: PaymentPeriod)
    case none
}
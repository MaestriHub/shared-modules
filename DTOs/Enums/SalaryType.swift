import Foundation

public enum SalaryType: Codable, Hashable, Equatable {
    public enum OkladPeriod: Codable {
        case day
        case month
        case hour
    }

    case procent(proceduresMap: [UUID : Decimal], period: OkladPeriod)
    case wage(price: Price, period: OkladPeriod)
    case none
}
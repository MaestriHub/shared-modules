import Foundation

public struct SalaryType: Codable, Hashable {

    public enum PaymentType: Codable, Hashable {
        case procent(procent: UInt)
        case value(value: Price)
    }
    
    public struct Wage: Codable, Hashable {
        public enum PaymentPeriod: Codable, Hashable {
            case day
            case month
            case hour
        }

        public var price: Price
        public var period: PaymentPeriod

        public init(
            price: Price,
            period: PaymentPeriod
        ) {
            self.price = price
            self.period = period
        }
    }

    public var procent: Int?
    public var grid: [UUID : PaymentType]?
    public var wage: Wage?

    public init(
        procent: Int?,
        grid: [UUID : PaymentType]?,
        wage: Wage?
    ) {
        self.procent = procent
        self.grid = grid
        self.wage = wage
    }
}
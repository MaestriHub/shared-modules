import Foundation

public typealias Seconds = TimeInterval

public extension Date {
    @inlinable
    @discardableResult
    func apply(_ component: TimeComponent, _ operation: TimeOperation) -> Date {
        return addingTimeInterval(operation.unwrap() * component.unwrap())
    }
    
    @inlinable
    @discardableResult
    func plus(_ component: TimeComponent) -> Date {
        return apply(component, .plus)
    }
    
    @inlinable
    @discardableResult
    func minus(_ component: TimeComponent) -> Date {
        return apply(component, .minus)
    }
}

public extension Date {
    enum TimeComponent: Sendable {
         case seconds(Int)
        
         @inlinable
         public static func minute(_ count: Int) -> Self { .seconds(count * 60) }
        
         @inlinable
         public static func hour(_ count: Int) -> Self { .minute(count * 60) }
        
         @inlinable
         public static func day(_ count: Int) -> Self { .hour(count * 24) }
         
         @inlinable
         func unwrap() -> Seconds {
             switch self {
                 case .seconds(let v):
                     return Seconds(v)
             }
         }
    }
    
    enum TimeOperation: Sendable {
        case minus
        case plus
        
        @inlinable
        func unwrap() -> Double {
            switch self {
                case .minus:
                    -1
                case .plus:
                    +1
            }
        }
    }
}

public extension Date {
    
    /// Конвертирует дату **из UTC** в указанный часовой пояс.
    /// 1 Jan 1970 00:00 UTC to: UTC+3 -->  31 Dec 1969 21:00
    func convertFromUTC(to timeZone: TimeZone) -> Date {
        minus(.seconds(timeZone.secondsFromGMT(for: self)))
    }

    /// Конвертирует дату **из указанного часового пояса** в UTC.
    /// 1 Jan 1970 00:00 UTC+3 from: UTC+3 -->  1 Jan 1970 03:00
    func convertToUTC(from timeZone: TimeZone) -> Date {
        plus(.seconds(timeZone.secondsFromGMT(for: self)))
    }
}

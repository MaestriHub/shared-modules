import Foundation

public typealias Seconds = TimeInterval

public extension Date {
    
    func apply(_ c: TimeComponent, _ o: TimeOperation) -> Date {
        return addingTimeInterval(o.unwrap() * c.unwrap())
    }
    
    func plus(_ c: TimeComponent) -> Date {
        return apply(c, .plus)
    }

    func minus(_ c: TimeComponent) -> Date {
        return apply(c, .minus)
    }
}

public enum TimeComponent: Sendable {
    case seconds(Int = 1)
    
    public static func minute(_ count: Int = 1) -> Self { .seconds(count * 60) }
    
    public static func hour(_ count: Int = 1) -> Self { .minute(count * 60) }
    
    public static func day(_ count: Int = 1) -> Self { .hour(count * 24) }
     
    func unwrap() -> Seconds {
        switch self {
            case .seconds(let s):
                 return Seconds(s)
        }
    }
}

public enum TimeOperation: Sendable {
    case minus
    case plus
    
    func unwrap() -> Double {
        switch self {
            case .minus:
                -1
            case .plus:
                +1
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

public extension Date {
    enum RoundingPrecision: Sendable {
        case none
        case milliseconds
        case millisecondsAndSeconds
    }
    
    func rounded(_ precision: RoundingPrecision) -> Date {
        switch precision {
        case .none:
            return self
        case .milliseconds:
            return self.roundMilliseconds()
        case .millisecondsAndSeconds:
            return self.roundMillisecondsAndSeconds()
        }
    }
    
    func roundMilliseconds() -> Date {
        let timeInterval = self.timeIntervalSince1970
        let roundedTimeInterval = floor(timeInterval)
        return Date(timeIntervalSince1970: roundedTimeInterval)
    }
    
    func roundMillisecondsAndSeconds() -> Date {
        let kSecondsInMinute: Int = 60
        
        let timeInterval = Int(self.timeIntervalSince1970)
        let seconds = timeInterval % kSecondsInMinute
        return Date(timeIntervalSince1970: TimeInterval(timeInterval - seconds))
    }
}

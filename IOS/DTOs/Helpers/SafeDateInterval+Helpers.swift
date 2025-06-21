import Foundation


public extension SafeDateInterval {
    
    ///     13:00      14:00
    /// input:   |----------|          c: .hour(2)
    ///
    ///     15:00      16:00
    /// output: |---------|
    ///
    func rightShift(_ c: TimeComponent) -> SafeDateInterval {
        let newEnd = end.plus(c)
        let newStart = start.plus(c)
        
        return SafeDateInterval(dateinterval: .init(start: newStart, end: newEnd))
    }

    ///     13:00      14:00
    /// input:   |----------|          c: .hour(2)
    ///
    ///     11:00      12:00
    /// output: |---------|
    ///
    func leftShift(_ c: TimeComponent) -> SafeDateInterval  {
        let newStart = start.minus(c)
        let newEnd = end.minus(c)
        
        return SafeDateInterval(dateinterval: .init(start: newStart, end: newEnd))
    }
        
    /// engaged   -      |---|
    /// consumer -  |----------|
    /// result - ok if consumer consume engaged
    func consumedBy(_ consumer: SafeDateInterval) -> Bool {
        guard consumer.start <= self.start else { return false }
        guard consumer.end >= self.end else { return false }
        return true
    }
}

public extension SafeDateInterval {
    
    // check docs for Date
    func convertFromUTC(to timeZone: TimeZone) throws -> SafeDateInterval {
        let newStart = start.convertFromUTC(to: timeZone)
        let newEnd = end.convertFromUTC(to: timeZone)
        
        return .init(dateinterval: .init(start: newStart, end: newEnd))
    }

    // check docs for Date
    func convertToUTC(from timeZone: TimeZone) throws -> SafeDateInterval {
        let newStart = start.convertToUTC(from: timeZone)
        let newEnd = end.convertToUTC(from: timeZone)
        
        return .init(dateinterval: .init(start: newStart, end: newEnd))
    }
}

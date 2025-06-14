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

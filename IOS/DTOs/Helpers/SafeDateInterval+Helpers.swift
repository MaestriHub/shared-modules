import Foundation


public extension SafeDateInterval {
    
    ///     13:00      14:00
    /// input:   |----------|          c: .hour(2)
    ///
    ///     15:00      16:00
    /// output: |---------|
    ///
    @discardableResult
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
    @discardableResult
    func leftShift(_ c: TimeComponent) -> SafeDateInterval  {
        let newStart = start.minus(c)
        let newEnd = end.minus(c)
        
        return SafeDateInterval(dateinterval: .init(start: newStart, end: newEnd))
    }
}

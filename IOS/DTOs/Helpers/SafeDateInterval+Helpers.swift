import Foundation

public extension SafeDateInterval {
    @discardableResult
    func plus(_ c: TimeComponent) -> SafeDateInterval {
        let newEnd = end.plus(c)
        let newStart = start.plus(c)
        
        return SafeDateInterval(dateinterval: .init(start: newStart, end: newEnd))
    }

    @discardableResult
    func minus(_ c: TimeComponent) -> SafeDateInterval  {
        let newStart = start.minus(c)
        let newEnd = end.minus(c)
        
        return SafeDateInterval(dateinterval: .init(start: newStart, end: newEnd))
    }
}

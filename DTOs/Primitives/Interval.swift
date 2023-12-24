import Foundation

public struct Interval: Parametable, Responsable, Equatable {
    
    public var start: Date
    public var end: Date
    
    public init(start: Date, end: Date) {
        self.start = start
        self.end = end
    }
}

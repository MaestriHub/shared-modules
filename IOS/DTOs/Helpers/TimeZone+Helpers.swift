import Foundation

public extension TimeZone {
    static var gmt: TimeZone {
        TimeZone(abbreviation: "GMT")!
    }
}

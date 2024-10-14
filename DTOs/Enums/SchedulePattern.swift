import Foundation

public enum SchedulePattern: Equatable, Decodable, Encodable{
    case week(week: Schedule.Week)
    case shift(shift: Schedule.Shift)
    case flexable(flexable: Schedule.Flexible)
}
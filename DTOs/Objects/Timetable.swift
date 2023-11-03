import Foundation
import SwifCron

/// Namespace для всех DTOs относящихся к Timetable
public enum Timetable {
    public enum Parameters {}
    public enum Responses {}
}

//MARK: - Parameters -

public extension Timetable.Parameters {
    
    struct Create: Parametable {
        public var timeZone: String
        
//        var sunday: DayTimetableBody?
//        var monday: DayTimetableBody?
//        var tuesday: DayTimetableBody?
//        var wednesday: DayTimetableBody?
//        var thursday: DayTimetableBody?
//        var friday: DayTimetableBody?
//        var saturday: DayTimetableBody?
        
        public var limit: DateInterval?
    }
    
    struct Patch: Parametable {
        var nickname: String?
        var avatar: String?
    }
}

//MARK: - Responses -

public extension Timetable.Responses {
    
    struct Full: Responsable {
        var id: UUID?
        var timeZone: String
        
//        var sunday: DayTimetableBody
//        var monday: DayTimetableBody
//        var tuesday: DayTimetableBody
//        var wednesday: DayTimetableBody
//        var thursday: DayTimetableBody
//        var friday: DayTimetableBody
//        var saturday: DayTimetableBody
//        
//        var offtimes: [OfftimeBody]
        var limit: IntervalDate?
        
//        init?(timetable: Timetable?, offtimes: [OfftimeBody]?) {
//            guard let timetable else { return nil }
//            self.id = timetable.id
//            self.timeZone = timetable.timeZone
//            self.sunday = DayTimetableBody(work: timetable.sunday.work, break: timetable.sunday.break)
//            self.monday = DayTimetableBody(work: timetable.monday.work, break: timetable.monday.break)
//            self.tuesday = DayTimetableBody(work: timetable.tuesday.work, break: timetable.tuesday.break)
//            self.wednesday = DayTimetableBody(work: timetable.wednesday.work, break: timetable.wednesday.break)
//            self.thursday = DayTimetableBody(work: timetable.thursday.work, break: timetable.thursday.break)
//            self.friday = DayTimetableBody(work: timetable.friday.work, break: timetable.friday.break)
//            self.saturday = DayTimetableBody(work: timetable.saturday.work, break: timetable.saturday.break)
//            
//            self.offtimes = offtimes ?? []
//            self.limit = timetable.limit
//        }
    }
    
    struct Partial: Responsable {
        public var id: UUID?
        public var name: String
        public var contacts: [Contact.Responses.Full]
    }
    
    struct Slot: Responsable {
        
    }
}

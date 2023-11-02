import Foundation
import SwifCron

struct DayTimetableBody: Content, Validatable {
    
    var work: IntervalDate?
    var `break`: IntervalDate?
    
    static func validations(_ validations: inout Validations) {}
}

//MARK: - Parameters -

struct TimetableBody: Content, Validatable {

    var timeZone: String
    
    var sunday: DayTimetableBody?
    var monday: DayTimetableBody?
    var tuesday: DayTimetableBody?
    var wednesday: DayTimetableBody?
    var thursday: DayTimetableBody?
    var friday: DayTimetableBody?
    var saturday: DayTimetableBody?
    
    var limit: IntervalDate?
    
    static func validations(_ validations: inout Validations) {}
}

//MARK: - Responses -

struct TimetableResponse: Content {

    var id: UUID?
    var timeZone: String
    
    var sunday: DayTimetableBody
    var monday: DayTimetableBody
    var tuesday: DayTimetableBody
    var wednesday: DayTimetableBody
    var thursday: DayTimetableBody
    var friday: DayTimetableBody
    var saturday: DayTimetableBody
    
    var offtimes: [OfftimeBody]
    var limit: IntervalDate?
    
    init?(timetable: Timetable?, offtimes: [OfftimeBody]?) {
        guard let timetable else { return nil }
        self.id = timetable.id
        self.timeZone = timetable.timeZone
        self.sunday = DayTimetableBody(work: timetable.sunday.work, break: timetable.sunday.break)
        self.monday = DayTimetableBody(work: timetable.monday.work, break: timetable.monday.break)
        self.tuesday = DayTimetableBody(work: timetable.tuesday.work, break: timetable.tuesday.break)
        self.wednesday = DayTimetableBody(work: timetable.wednesday.work, break: timetable.wednesday.break)
        self.thursday = DayTimetableBody(work: timetable.thursday.work, break: timetable.thursday.break)
        self.friday = DayTimetableBody(work: timetable.friday.work, break: timetable.friday.break)
        self.saturday = DayTimetableBody(work: timetable.saturday.work, break: timetable.saturday.break)
        
        self.offtimes = offtimes ?? []
        self.limit = timetable.limit
    }
}

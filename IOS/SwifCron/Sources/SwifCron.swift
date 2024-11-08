//
//  SwifCron.swift
//  SwifCron
//
//  Created by Mihael Isaev on 06/03/2019.
//

import Foundation

public struct SwifCron {
    /// String expression
    public let expression: String
    
    /// Internal expression mode
    enum ExpressionMode {
        case exactDayOfMonthButAnyDayOfWeek, exactDayOfWeekButAnyDayOfMonth, mixed
    }
    let mode: ExpressionMode
    
    /// Parsed parts of cron expression
    public let daysOfMonth, months, daysOfWeek, weeksOfYear: [Int]

    /**
     Supports only digit values yet
     - Parameters:
       - dayOfMonth: expression string
       - month: expression string (doesn't support name of month, only digits)
       - dayOfWeek: expression string (sunday is 0, doesn't support name of day, so use only digits)
       - weeksOfYear: expression string
        // TODO: year implementation

     Supported values:
     - *: for any value
     - -: to set periods like `1-10`
     - ,: (comma) value list separator
     - /:(slash) for step values
     */
    public init(_ expression: String) throws {
        self.expression = expression
        let parts = expression.components(separatedBy: " ")

        // add new seconds parameter (Quartz cron) but leave backward compatibility with UNIX cron
        guard parts.count == 4 /* || parts.count == 5 */ else {
            throw SwifCronError(reason: "Timetable 'cron' string should contain 4 parts separated by space")
        }
        let offset = 0

        if parts[offset + 2] == "*" && parts[offset + 3] == "*" {
            mode = .exactDayOfMonthButAnyDayOfWeek
        } else if parts[offset + 0] == "*" && parts[offset + 1] == "*" && (parts[offset + 2] != "*" || parts[offset + 3] != "*") {
            mode = .exactDayOfWeekButAnyDayOfMonth
        } else {
            mode = .mixed
        }

        // Cron expression parsed values
        daysOfMonth = try ExpressionParser.parse(part: parts[offset + 0], .daysOfMonth)
        months = try ExpressionParser.parse(part: parts[offset + 1], .months)
        daysOfWeek = try ExpressionParser.parse(part: parts[offset + 2], .daysOfWeek)
        weeksOfYear = try ExpressionParser.parse(part: parts[offset + 3], .weeksOfYear)
    }
    
    /* Returns a next date based on cron string expression
     *
     * You could use:
     * * for any value
     * use `-` to set periods like `1-10`
     * use `,`(comma) value list separator
     * use `/`(slash) for step values
     *
     * Supports only digit values yet
     **/
    public func next(
        from date: Date = Date(),
        calendar: Calendar? = nil,
        timeZone: TimeZone? = nil
    ) throws -> Date {
        // Calendar with UTC-0 time zone
        var nonNilCalendar: Calendar
        switch (calendar, timeZone) {
        case (let calendar?, let timeZone?):
            nonNilCalendar = calendar
            nonNilCalendar.timeZone = timeZone
        case (let calendar?, nil):
            nonNilCalendar = calendar
            nonNilCalendar.timeZone = calendar.timeZone
        case (nil, let timeZone?):
            nonNilCalendar = Calendar(identifier: .gregorian)
            nonNilCalendar.timeZone = timeZone
        case (nil, nil):
            nonNilCalendar = Calendar(identifier: .gregorian)
            guard let timeZone = TimeZone(secondsFromGMT: 0) else {
                throw SwifCronError(reason: "Unable to get UTC+0 time zone")
            }
            nonNilCalendar.timeZone = timeZone
        }
        
        // Value for `from` date
        let currentDayOfMonth = nonNilCalendar.component(.day, from: date)
        let currentMonth = nonNilCalendar.component(.month, from: date)
        let currentDayOfWeek = nonNilCalendar.component(.weekday, from: date) - 1
        let currentWeekOfYear = nonNilCalendar.component(.weekOfYear, from: date)
        let currentYear = nonNilCalendar.component(.year, from: date)
        
        // Looking for the right next date
        let nextHour = (value: 0, offset: 0)

        // Not every month contains 31 day, so we should exclude non-existing days
        let filteredDaysOfMonth = try Helper.filterDaysOfMonth(month: currentMonth, year: currentYear, days: daysOfMonth)

        // Not every year contains 53 weeks, so we should exclude non-existing week as well
        // However, we'll have to filter weeks for every year offset, thus it's done elsewhere

        var nextDayOfMonth = try Helper.findNext(current: currentDayOfMonth, from: filteredDaysOfMonth, offset: nextHour.offset)
        var nextMonth = try Helper.findNext(current: currentMonth, from: months, offset: nextDayOfMonth.offset)
        
        if nextMonth.value - currentMonth > 0 {
            nextDayOfMonth.value = daysOfMonth[0]
        }
        if nextMonth.offset > 0 {
            nextDayOfMonth.value = daysOfMonth[0]
            nextMonth.value = months[0]
        }
        
        switch mode {
        case .exactDayOfMonthButAnyDayOfWeek:
            return try Helper.getNextDateByDom(
                day: nextDayOfMonth.value,
                month: nextMonth.value,
                year: currentYear + nextMonth.offset,
                calendar: nonNilCalendar
            )
        case .exactDayOfWeekButAnyDayOfMonth:
            return try Helper.getNextDateByDow(
                currentDow: currentDayOfWeek,
                availableDows: daysOfWeek,
                currentWoy: currentWeekOfYear,
                availableWoys: weeksOfYear,
                day: currentDayOfMonth,
                month: currentMonth,
                year: currentYear,
                calendar: nonNilCalendar,
                cron: self
            )
        case .mixed:
            let nextDateByDow = try Helper.getNextDateByDow(
                currentDow: currentDayOfWeek,
                availableDows: daysOfWeek,
                currentWoy: currentWeekOfYear,
                availableWoys: weeksOfYear,
                day: currentDayOfMonth,
                month: currentMonth,
                year: currentYear,
                calendar: nonNilCalendar,
                cron: self
            )
            let nextDateByDom = try Helper.getNextDateByDom(
                day: nextDayOfMonth.value,
                month: nextMonth.value,
                year: currentYear + nextMonth.offset,
                calendar: nonNilCalendar
            )
            return nextDateByDow < nextDateByDom ? nextDateByDow : nextDateByDom
        }
    }
}

extension SwifCron: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(expression)
    }
}

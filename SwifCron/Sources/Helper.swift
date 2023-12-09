//
//  DateMaker.swift
//  SwifCron
//
//  Created by Mihael Isaev on 06/03/2019.
//

import Foundation

struct Helper {

    static var WeekOfYearCache: [Int: Int] = [:]

    /// Returns a next day by provided minute, hour, minutem day, month, year, calendar
    static func getNextDateByDom(day: Int, month: Int, year: Int, calendar: Calendar) throws -> Date {
        let componentsByDom = DateComponents(year: year, month: month, day: day, hour: 0, minute: 0, second: 0)
        guard let nextDateByDayOfMonth = calendar.date(from: componentsByDom) else {
            throw SwifCronError(reason: "Unable to generate next date from components")
        }
        return nextDateByDayOfMonth
    }
    
    /// Returns a next day by provided day of week, offset, minute, hour, minutem day, month, year, calendar
    static func getNextDateByDow(currentDow: Int, availableDows: [Int], currentWoy: Int, availableWoys: [Int], day: Int, month: Int, year: Int, calendar: Calendar, cron: SwifCron) throws -> Date {
        let dowComponents = try findComponentsByDayOfWeek(currentDow: currentDow, availableDows: availableDows, currentWoy: currentWoy, availableWoys: availableWoys, currentDay: day, currentMonth: month, year: year, calendar: calendar)

        let componentsByDow = DateComponents(year: year + dowComponents.yearOffset, month: dowComponents.month, day: dowComponents.day, hour: 0, minute: 0, second: 0, weekOfYear: 1)
        guard let date = calendar.date(from: componentsByDow) else {
            throw SwifCronError(reason: "Unable to generate next date from components")
        }
        return date
    }
    
    /// Returns is provided year is a leap year
    static func isLeapYear(_ year: Int) -> Bool {
        return ((year % 100 != 0) && (year % 4 == 0)) || year % 400 == 0
    }
    
    /// Removes non-existing month's days from array
    static func filterDaysOfMonth(month: Int, year: Int, days: [Int]) throws -> [Int] {
        let maxDay = Self.lastDayOfMonth(month, year: year)
        switch maxDay {
        case 31: return days
        default: return days.filter { $0 <= maxDay }
        }
    }
    
    /// Returns a last day for month
    static func lastDayOfMonth(_ month: Int, year: Int) -> Int {
        switch month {
        case 2: return isLeapYear(year) ? 29 : 28
        case 4, 6, 9, 11: return 30
        default: return 31
        }
    }

    static func filterWeeksOfYear(year: Int, calendar: Calendar, weeks: [Int]) -> [Int] {
        let maxWeek = Self.lastWeekOfYear(year, calendar: calendar)
        switch maxWeek {
        case 53: return weeks
        default: return weeks.filter { $0 <= maxWeek }
        }
    }

    static func lastWeekOfYear(_ year: Int, calendar: Calendar) -> Int {
        if let cached = Self.WeekOfYearCache[year] {
            return cached
        }
        let lastWeek = DateComponents(calendar: calendar, weekday: 1, weekOfYear: 53, yearForWeekOfYear: year).isValidDate ? 53 : 52
        Self.WeekOfYearCache[year] = lastWeek
        return lastWeek
    }

    /// Returns next available value from array
    static func findNext(current: Int, from available: [Int], availableWithOffset1: [Int]? = nil, offset: Int) throws -> (value: Int, offset: Int) {
        if let next = available.first(where: { $0 >= current + offset }) {
            return (next, 0)
        }
        switch availableWithOffset1 {
        case let available?:
            if let first = available.first {
                return (first, 1)
            }
        case nil:
            if let first = available.first {
                return (first, 1)
            }
        }
        throw SwifCronError(reason: "Unable to generate next value")
    }
    
    /// Returns day, month, yearOffset components
    /// to build a date from provided day of week
    static func findComponentsByDayOfWeek(currentDow: Int,
                                          availableDows: [Int],
                                          currentWoy: Int,
                                          availableWoys: [Int],
                                          currentDay dom: Int,
                                          currentMonth month: Int,
                                          year: Int,
                                          calendar: Calendar) throws -> (day: Int, month: Int, yearOffset: Int) {
        var nextWoy: (value: Int, offset: Int)

        if availableWoys.contains(currentWoy),
           availableDows.contains(currentDow) {
            return (dom, month, 0)
        }
        
        let filteredWoys = Self.filterWeeksOfYear(year: year, calendar: calendar, weeks: availableWoys)
        let filteredWoysWithOffset1 = Self.filterWeeksOfYear(year: year + 1, calendar: calendar, weeks: availableWoys)

        var dowOffset = 0
        var woyOffset = 0
        var totalOffset = -1
        var week = currentWoy
        var day = currentDow

        while totalOffset < 0 {
            nextWoy = try findNext(current: week, from: filteredWoys, availableWithOffset1: filteredWoysWithOffset1, offset: 0)
            woyOffset = nextWoy.value - currentWoy + nextWoy.offset * Self.lastWeekOfYear(year, calendar: calendar)
            if woyOffset > 0 {
                day = 0
            }
            let nextDow = try findNext(current: day, from: availableDows, offset: 0)
            woyOffset = nextWoy.value - currentWoy + nextWoy.offset * Self.lastWeekOfYear(year, calendar: calendar)
            dowOffset = nextDow.value - currentDow
            totalOffset = dowOffset + 7 * woyOffset
            week = nextWoy.value + 1
        }

        var nextDom = dom + totalOffset
        var nextMonth = month
        var maxDom = lastDayOfMonth(month, year: year)
        var yearOffset = 0

        while nextDom > maxDom {
            nextDom -= maxDom
            nextMonth += 1
            if nextMonth > 12 {
                yearOffset += 1
                nextMonth -= 12
            }
            maxDom = lastDayOfMonth(nextMonth, year: year + yearOffset)
        }

        return (nextDom, nextMonth, yearOffset)
    }
}

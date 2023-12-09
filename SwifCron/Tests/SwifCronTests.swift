import XCTest
@testable import SwifCron

final class SwifCronTests: XCTestCase {
    let testDate = Date(timeIntervalSince1970: 1551904895) // 2019-03-06 20:41:35 +0000
    
    func testAnyDate() {
        do {
            let nextDate = try SwifCron("* * * *").next(from: testDate)
            XCTAssertEqual(String(describing: nextDate), "2019-03-06 00:00:00 +0000")
        } catch {
            XCTFail(String(describing: error))
        }
    }

    func testExactDowWeekAndDomMonth() {
        do {
            let nextDate = try SwifCron("11 4 3 11").next(from: testDate)
            XCTAssertEqual(String(describing: nextDate), "2019-03-13 00:00:00 +0000")
        } catch {
            XCTFail(String(describing: error))
        }
    }

    func testExactDowWeekAndDomInNextYear() {
        do {
            let nextDate = try SwifCron("28 12 4 52").next(from: Date(timeIntervalSince1970: 1483088400))
            XCTAssertEqual(String(describing: nextDate), "2017-12-28 00:00:00 +0000")
        } catch {
            XCTFail(String(describing: error))
        }
    }

    /// same as `exactDowAndDomInNextYear` but 53rd week does not exist in 2017
    func testExactDowAndDomInNextYearWeekIsNonexistent() {
        XCTAssertThrowsError(
            try SwifCron("28 12 4 53").next(from: Date(timeIntervalSince1970: 1483088400)),
            "Unable to generate next value"
        )
    }

    func testExactDomAndMonth() {
        do {
            let nextDate = try SwifCron("11 4 * *").next(from: testDate)
            XCTAssertEqual(String(describing: nextDate), "2019-04-11 00:00:00 +0000")
        } catch {
            XCTFail(String(describing: error))
        }
    }

    func testExactDom() {
        do {
            let nextDate = try SwifCron("11 * * *").next(from: testDate)
            XCTAssertEqual(String(describing: nextDate), "2019-03-11 00:00:00 +0000")
        } catch {
            XCTFail(String(describing: error))
        }
    }

    // TODO: Adapt these tests for DoM

    func testComplexDomCondition() {
        do {
            let nextDate = try SwifCron("1-3,5/3 * * *").next(from: testDate)
            XCTAssertEqual(String(describing: nextDate), "2019-03-08 00:00:00 +0000")
        } catch {
            XCTFail(String(describing: error))
        }
    }

    func testEverySecondDay() {
        do {
            let nextDate = try SwifCron("*/2 * * *").next(from: testDate)
            XCTAssertEqual(String(describing: nextDate), "2019-03-07 00:00:00 +0000")
        } catch {
            XCTFail(String(describing: error))
        }
    }
    
    func testEveryThirdMonth() {
        do {
            let nextDate = try SwifCron("* */3 * *").next(from: testDate)
            XCTAssertEqual(String(describing: nextDate), "2019-04-01 00:00:00 +0000")
        } catch {
            XCTFail(String(describing: error))
        }
    }
    
    func testEveryTwelvthMonth() {
        do {
            let nextDate = try SwifCron("* */12 * *").next(from: testDate)
            XCTAssertEqual(String(describing: nextDate), "2020-01-01 00:00:00 +0000")
        } catch {
            XCTFail(String(describing: error))
        }
    }

    func testExactDayOfEveryTwelvthMonth() {
        do {
            let nextDate = try SwifCron("2 */12 * *").next(from: testDate)
            XCTAssertEqual(String(describing: nextDate), "2020-01-02 00:00:00 +0000")
        } catch {
            XCTFail(String(describing: error))
        }
    }
    
    func testExactDayOfEveryTwelvthMonthOrExactDow() {
        do {
            let nextDate = try SwifCron("2 */12 6 *").next(from: testDate)
            XCTAssertEqual(String(describing: nextDate), "2019-03-09 00:00:00 +0000")
        } catch {
            XCTFail(String(describing: error))
        }
    }
    
    func testExactDow() {
        do {
            let nextDate = try SwifCron("* * 6 *").next(from: testDate)
            XCTAssertEqual(String(describing: nextDate), "2019-03-09 00:00:00 +0000")
        } catch {
            XCTFail(String(describing: error))
        }
    }

    func testEveryThirdWeek() {
        do {
            let nextDate = try SwifCron("* * * */3").next(from: testDate)
            XCTAssertEqual(String(describing: nextDate), "2019-03-06 00:00:00 +0000")
        } catch {
            XCTFail(String(describing: error))
        }
    }

    func testEveryTwelvthWeek() {
        do {
            let nextDate = try SwifCron("* * * */12").next(from: testDate)
            XCTAssertEqual(String(describing: nextDate), "2019-03-24 00:00:00 +0000")
        } catch {
            XCTFail(String(describing: error))
        } // день недели сохраняется (среда), но в этом случае не должен (понедельник)
    }

    static var allTests = [
        ("testAnyDate", testAnyDate),
        ("testExactDowWeekAndDomMonth", testExactDowWeekAndDomMonth),
        ("testExactDowWeekAndDomInNextYear", testExactDowWeekAndDomInNextYear),
        ("testExactDowAndDomInNextYearWeekIsNonexistent", testExactDowAndDomInNextYearWeekIsNonexistent),
        ("testExactDomAndMonth", testExactDomAndMonth),
        ("testExactDom", testExactDom),
        ("testComplexDomCondition", testComplexDomCondition),
        ("testEverySecondDay", testEverySecondDay),
        ("testEveryThirdMonth", testEveryThirdMonth),
        ("testEveryTwelvthMonth", testEveryTwelvthMonth),
        ("testExactDayOfEveryTwelvthMonth", testExactDayOfEveryTwelvthMonth),
        ("testExactDayOfEveryTwelvthMonthOrExactDow", testExactDayOfEveryTwelvthMonthOrExactDow),
        ("testExactDow", testExactDow),
        ("testEveryThirdWeek", testEveryThirdWeek),
        ("testEveryTwelvthWeek", testEveryTwelvthWeek),
    ]
}

import XCTest
@testable import DTOs

final class DateExtensionsTests: XCTestCase {
    
    func testChangeDate() {
        let date = Date
            .now
            .plus(.day(10))
            .minus(.hour(5))
            .apply(.minute(10), .plus)
            .apply(.seconds(20), .minus)
        
        XCTAssertEqual(date.timeIntervalSince(Date.now), 846580, accuracy: 0.1)
    }
    
    func testUTCToLocalConversion() {
        let backendGMTDate = Date.now
        
        let myLocalBSTDate = backendGMTDate.convertFromUTC(to: TimeZone(identifier: "BST")!)
        
        XCTAssertEqual(
            myLocalBSTDate.timeIntervalSince1970,
            Date.now.timeIntervalSince1970 - 6*60*60,
            accuracy: 0.1
        )
    }
    
    func testLocalToUTCConversion() {
        let myLocalBSTDate = Date.now
        
        let backendGMTDate = myLocalBSTDate.convertToUTC(from: TimeZone(identifier: "BST")!)
        
        XCTAssertEqual(
            backendGMTDate.timeIntervalSince1970,
            Date.now.timeIntervalSince1970 + 6*60*60,
            accuracy: 0.1
        )
    }
    
    func testApplyPerformance() {
        let date = Date()
        measure {
            _ = date.apply(.hour(1), .plus)
        }
    }
    
    func testTimeZoneConversionPerformance() {
        let date = Date()
        let timeZone = TimeZone(identifier: "America/New_York")!
        measure {
            _ = date.convertFromUTC(to: timeZone)
        }
    }
}

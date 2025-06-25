import XCTest
@testable import DTOs

final class SafeDateIntervalCoderTests: XCTestCase {

    public func test_coders() async throws {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        let now = Date.now
        let tomorrow = Date.now.plus(.day())
        let nowString = dateFormatter.string(from: now)
        let tomorrowString = dateFormatter.string(from: tomorrow)
        
        let dateInterval = DateInterval(start: now, end: tomorrow)
        let safeInterval = SafeDateInterval(dateinterval: dateInterval)
                                            
        let encoder = JSONEncoder()
        let encoded = try encoder.encode(safeInterval)
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(SafeDateInterval.self, from: encoded)
        
        let jsonString = String(data: encoded, encoding: .utf8)!
        XCTAssertTrue(
            "{\"start\":\"\(nowString)\",\"end\":\"\(tomorrowString)\"}" == jsonString ||
            "{\"end\":\"\(tomorrowString)\",\"start\":\"\(nowString)\"}" == jsonString
        )
        
        XCTAssertEqual(decoded.start.description, now.description)
        XCTAssertEqual(decoded.end.description, tomorrow.description)
    }
}



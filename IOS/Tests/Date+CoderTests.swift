import XCTest
@testable import DTOs

final class DateCoderTests: XCTestCase {

    public func test_encoder() async throws {
        let encoder = JSONEncoder.build(JSONEncoder.withRoundedMilliseconds)
        let now = Date.now
        
        let encNowDate = try encoder.encode(now)
        
        let jsonString = String(data: encNowDate, encoding: .utf8)!
        XCTAssertTrue(jsonString.contains((".000Z")))
    }
    
    public func test_decoder() async throws {
        let encoder = JSONEncoder.build(JSONEncoder.withMilliseconds)
        let now = Date.now
        
        let encNowDate = try encoder.encode(now)
        let encodedDate = String(data: encNowDate, encoding: .utf8)!
        
        let decoder = JSONDecoder.build(JSONDecoder.withRoundedMilliseconds)
        let decodedDate = try decoder.decode(Date.self, from: encNowDate)
        let decodedFormattedDate = decodedDate.ISO8601Format(.Strategy(includingFractionalSeconds: true))

        XCTAssertTrue(!encodedDate.contains((".000Z")))
        XCTAssertTrue(decodedFormattedDate.contains((".000Z")))
    }
}


import XCTest
@testable import DTOs

final class DateCoderTests: XCTestCase {

    public func test_encoder() async throws {
        let encoder = JSONEncoder.with(.roundedDate(.millisecondsAndSeconds))
        let now = Date.now
        
        let encNowDate = try encoder.encode(now)
        
        let jsonString = String(data: encNowDate, encoding: .utf8)!
        print(jsonString)
        XCTAssertTrue(jsonString.contains((":00.000Z")))
    }
    
    public func test_decoder() async throws {
        let encoder = JSONEncoder.with(.roundedDate(.none))
        let now = Date.now
        
        let encNowDate = try encoder.encode(now)
        let encodedDate = String(data: encNowDate, encoding: .utf8)!
        
        let decoder = JSONDecoder.with(.roundedDate(.millisecondsAndSeconds))
        let decodedDate = try decoder.decode(Date.self, from: encNowDate)
        let decodedFormattedDate = decodedDate.ISO8601Format(.Strategy(includingFractionalSeconds: true))

        print(encodedDate)
        XCTAssertTrue(!encodedDate.contains((":00.000Z")))
        XCTAssertTrue(decodedFormattedDate.contains((":00.000Z")))
    }
}


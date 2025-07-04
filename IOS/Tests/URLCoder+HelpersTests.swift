import XCTest
@testable import DTOs

final class URLCoderTests: XCTestCase {
    public func test_defaultURLDateEncoder() async throws {
        let now = Date(timeIntervalSince1970: 1684144245.123) // 2023-05-15T09:50:45.123Z
        let encode = defaultURLDateEncode()
        let result = try encode(now)
        
        XCTAssertEqual(result, "2023-05-15T09%3A50%3A00.000Z")
    }
}

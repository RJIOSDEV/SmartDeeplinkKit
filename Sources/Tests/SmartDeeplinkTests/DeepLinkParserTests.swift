import XCTest
@testable import SmartDeeplink

final class DeepLinkParserTests: XCTestCase {
    
    func testHomeDeepLink() {
        let url = URL(string: "myapp://home")!
        let result = DeepLinkParser.parse(url: url)
        XCTAssertEqual(result, .home)
    }

    func testProfileDeepLinkWithID() {
        let url = URL(string: "myapp://profile?id=123")!
        let result = DeepLinkParser.parse(url: url)
        XCTAssertEqual(result, .profile(userId: "123"))
    }

    func testUnknownDeepLink() {
        let url = URL(string: "myapp://nonexistent")!
        let result = DeepLinkParser.parse(url: url)
        XCTAssertEqual(result, .unknown)
    }
    func testProfilePathDeepLink() {
        let url = URL(string: "myapp://profile/123")!
        let result = DeepLinkParser.parse(url: url)
        XCTAssertEqual(result, .profile(userId: "123"))
    }
    func testAnalyticsHandlerIsCalled() {
        let expectation = XCTestExpectation(description: "Analytics handler called")

        DeepLinkParser.analyticsHandler = { url, result in
            XCTAssertEqual(url.absoluteString, "myapp://home")
            XCTAssertEqual(result, .home)
            expectation.fulfill()
        }

        _ = DeepLinkParser.parse(url: URL(string: "myapp://home")!)

        wait(for: [expectation], timeout: 1)
    }

    func testDebugLoggingDoesNotCrash() {
        DeepLinkParser.isDebugLoggingEnabled = true
        _ = DeepLinkParser.parse(url: URL(string: "myapp://settings")!)
        DeepLinkParser.isDebugLoggingEnabled = false
    }


}

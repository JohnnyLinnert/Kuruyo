import XCTest
@testable import busping
class TokyuBusHTMLRepositoryTests: XCTestCase {
    let repository = TokyuBusHTMLRepository()

    func test_getsHTMLFromTokyu() {
        let expectation = self.expectation(description: "complete expectation")
        let html = repository.getHTML()
        html.onSuccess { result in
            expectation.fulfill()
            XCTAssertNotNil(result)
        }

        self.waitForExpectations(timeout: 2, handler: nil)
    }
}

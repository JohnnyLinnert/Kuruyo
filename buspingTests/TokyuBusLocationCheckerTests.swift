import XCTest
@testable import busping

class TokyuBusLocationCheckerTests: XCTestCase {
    let checker = TokyuBusLocationChecker()
    
    func test_canFindMoriyaToshokan() {
        let expectation = self.expectation(description: "complete expectation")
        
        let stop = checker.getMoriyaToshokan()
        stop.onSuccess { result in
            expectation.fulfill()
            XCTAssertEqual(result.name, "守屋図書館")
        }

        self.waitForExpectations(timeout: 2, handler: nil)
    }
}

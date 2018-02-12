import XCTest
@testable import busping

class TokyuBusLocationCheckerTests: XCTestCase {
    let checker = TokyuBusLocationChecker()
    
    func test_checkIfBusIsThreeStopsAway() {
        let stopToCheck = DefaultBusStopFactory().findStopByScanningDown(
            stopsAway: 3,
            from: "祐天寺",
            with: FakeHTML().result
        )
        
        let allLeftBusLocations = DefaultBusLocationFactory().getLeftBusLocations(
            with: FakeHTML().result
        )
        
        let isThreeStopsAway = checker.checkIfBusIsThreeStopsAway(
            at: stopToCheck!,
            busLocations: allLeftBusLocations
        )
        
        XCTAssertTrue(isThreeStopsAway)
    }
}

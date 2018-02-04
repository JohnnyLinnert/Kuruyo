import XCTest
@testable import busping
class DefaultBusLocationFactoryTests: XCTestCase {
    let factory = DefaultBusLocationFactory()
    
    func test_getsLeftBusLocations() {
        let locations = factory.getLeftBusLocations(with: FakeHTML().result)
        XCTAssertNil(locations[0].stop)
        XCTAssertEqual(locations[1].stop!.name, "深沢不動前（駒沢通り")
    }
    
    func test_getsRightBusLocations() {
        let locations = factory.getRightBusLocations(with: FakeHTML().result)
        XCTAssertNil(locations[0].stop)
        XCTAssertEqual(locations[1].stop!.name, "守屋図書館")
    }
}

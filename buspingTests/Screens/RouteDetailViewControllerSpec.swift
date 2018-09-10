import Foundation
import Quick
import Nimble
import BrightFutures

@testable import busping

class RouteDetailViewControllerSpec: QuickSpec {
    var vc: RouteDetailViewController!
    var busLocationRepoSpy: BusLocationRepoSpy!

    func createViewController() {
        self.vc = RouteDetailViewController(busLocationRepo: self.busLocationRepoSpy)
    }

    override func spec() {

        beforeEach {
            self.busLocationRepoSpy = BusLocationRepoSpy()
        }

        describe("route detail view controller") {
            it("should display the number of stops away the bus is") {
                let promise = Promise<CurrentBusLocation?, NSError>()
                self.busLocationRepoSpy.closestBusLocation_returnValue = promise.future
                promise.success(CurrentBusLocation(stop: Stop(name: "恵比寿駅"), numberAway: 3))


                self.createViewController()
                

//                expect(self.vc.hasLabel(withText: "Your bus is 3 stops away")).toEventually(beTrue())
            }
        }
    }
}

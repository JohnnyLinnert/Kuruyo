import Foundation
import Quick
import Nimble
import BrightFutures

@testable import busping

class RouteDetailViewControllerSpec: QuickSpec {
    var vc: RouteDetailViewController!
    var busLocationRepoSpy: BusLocationRepoSpy!
    var reloaderSpy: AutomaticReloaderSpy!

    func createViewController() {
        self.vc = RouteDetailViewController(
            busLocationRepo: self.busLocationRepoSpy,
            fromStop: Stop(name: "恵比寿駅"),
            toStop: Stop(name: "用賀駅"),
            automaticReloader: reloaderSpy
        )
    }

    override func spec() {

        beforeEach {
            self.busLocationRepoSpy = BusLocationRepoSpy()
            self.reloaderSpy = AutomaticReloaderSpy()
        }

        describe("route detail view controller") {
            it("should display the number of stops away the bus is") {
                let promise = Promise<CurrentBusLocation?, NSError>()
                self.busLocationRepoSpy.closestBusLocation_returnValue = promise.future
                promise.success(CurrentBusLocation(stop: Stop(name: "恵比寿駅"), numberAway: 3))


                self.createViewController()

                expect(self.vc.hasLabel(withText: "The next bus is currently at 恵比寿駅 which is 3 stops away.")).toEventually(beTrue())
            }
        }

        describe("automatic reloading") {
            it("should happen every 15 seconds") {
                self.createViewController()


                self.vc.viewDidAppear(false)

                
                expect(self.reloaderSpy.performOnRepeat_intervalArg.doubleValue).to(equal(15.0))
            }

            it("it should no longer happen when the view is not visible anymore") {
                self.createViewController()


                self.vc.viewWillDisappear(false)


                expect(self.reloaderSpy.cancelAuomtaticReloadWasCalled).to(beTrue())
            }
        }
    }
}

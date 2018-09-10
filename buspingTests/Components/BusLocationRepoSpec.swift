import Foundation
import Nimble
import Quick

@testable import busping

class BusLocationRepoSpec: QuickSpec {
    var repo: TokyuBusLocationRepository!

    func createRepo() {
        let fakeHttp = FakeKuruyoHTTP()
        fakeHttp.jsonString = FakeJSONFixture.busLocationsResponse()
        repo = TokyuBusLocationRepository(http: fakeHttp)
    }

    override func spec() {
        describe("bus location repo") {
            it("gets the closest bus location") {
                self.createRepo()

                waitUntil { done in
                    self.repo.closestBusLocation(fromStop: Stop(name: "恵比寿駅"), toStop: Stop(name: "下五丁目"), line: "恵32").onSuccess(callback: { busLocation in
                        expect(busLocation!.stop.name).to(equal("恵比寿駅"))
                        expect(busLocation!.numberAway).to(equal(3))
                        done()
                    }).onFailure(callback: { error in
                        assertionFailure()
                    })

                }
            }
        }
    }
}

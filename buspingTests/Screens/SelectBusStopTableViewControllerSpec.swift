import Foundation
import Quick
import Nimble
import BrightFutures

@testable import busping
class SelectBusStopTableViewControllerSpec: QuickSpec {
    var fakeKuruyoHTTP: FakeKuruyoHTTP!
    var busStopRepository: BusStopRepository!
    var vc: SelectBusStopTableViewController!
    
    func createViewController() {
        vc = SelectBusStopTableViewController(busStopRepo: busStopRepository)
        vc.viewDidLoad()
    }
    
    override func spec() {
        
        beforeEach {
            self.fakeKuruyoHTTP = FakeKuruyoHTTP()
            self.busStopRepository = TokyuBusStopRepository(http: self.fakeKuruyoHTTP)
        }
        
        describe("the select bus stop tableview controller") {
            context("when I arrive on the screen") {
                it("should display a list of bus stops") {
                    self.createViewController()


                    expect(self.vc.allStops).toEventuallyNot(beNil())
                    expect(self.vc.hasLabel(withText: "恵比寿駅")).toEventually(beTrue())
                }
            }
        }
    }
}
